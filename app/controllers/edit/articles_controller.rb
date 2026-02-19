class Edit::ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :update, :destroy]
  include Rails.application.routes.url_helpers

  # GET /articles
  def index
    if params[:section_id]
      @articles = Article.with_attached_image.where("section_id = ?",params[:section_id]).where("static_page = false").order("id DESC")
    else
      @articles = Article.with_attached_image.where("static_page = false").order("id DESC")
    end

    @articles.each do |article|
      if article.image.attached?
        article.write_attribute(:image_url, url_for(article.image.variant(resize_to_limit: [400, 400]).processed))
      end
    end

    render json: @articles, :include => {:author => {:only => :name}}
  end

  # GET /articles/1
  def show
    if @article.image.attached?
      @image_url = url_for(@article.image.variant(resize_to_limit: [1600, 1600]).processed)
    else
      @image_url = nil
    end
    # render json: { article: @article, image_url: @image_url} 
    render json: { article: @article, image_url: @image_url }
  end

  # POST /articles
  def create
    puts article_params
    @article = Article.new(article_params)

    if @article.save
      render json: @article, status: :created, location: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    puts @article
    puts params
    if params[:image]
      puts "attempting to attach"
      @article.image.attach(params[:image])
    end
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.with_attached_image.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def article_params
      params.permit(:author_id, :section_id, :title, :dek, :content, :image, :caption, :credit, :url, :published, :static_page, :hero_image)
    end
end
