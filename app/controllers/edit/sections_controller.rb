class Edit::SectionsController < ApplicationController
  before_action :set_section, only: [:show, :update, :destroy]
  include Rails.application.routes.url_helpers

  # GET /sections
  def index
    @sections = Section.all

    render json: @sections
  end

  # GET /sections/1
  def show
    @section = Section.find(params[:id])
    @articles = Article.with_attached_image.where("section_id = ?",params[:id]).where("static_page = false").order("id DESC")

    @articles.each do |article|
      if article.image.attached?
        article.write_attribute(:image_url, url_for(article.image.variant(resize_to_limit: [800, 800]).processed))
      end
      if article.author
        article.write_attribute(:author, {name: article.author.name})
      end
    end

    @section.write_attribute(:article_list, @articles)

    render json: @section, include: [ :features ]
  end

  # POST /sections
  def create
    @section = Section.new(section_params)

    if @section.save
      render json: @section, status: :created, location: @section
    else
      render json: @section.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sections/1
  def update
    if @section.update(section_params)
      render json: @section
    else
      render json: @section.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sections/1
  def destroy
    @section.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section
      @section = Section.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def section_params
      params.require(:section).permit(:title, :short_title, :top_story)
    end
end
