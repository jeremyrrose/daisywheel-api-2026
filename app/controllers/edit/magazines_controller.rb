class Edit::MagazinesController < ApplicationController
  before_action :set_magazine, only: [:show, :update, :destroy]

  # GET /magazines
  def index
    @magazines = Magazine.all

    render json: @magazines
  end

  # GET /magazines/1
  def show
    @sections = Section.all.select("id, title, short_title")
    @pages_array = []
    if @magazine.pages_order[0]
      @magazine.pages_order.each do |page|
        article = Article.find(page)
        @pages_array.push({title: article.title, id:article.id})
      end
    end
    render json: { magazine: @magazine, sections: @sections, pages: @pages_array }
  end

  # POST /magazines
  def create
    @magazine = Magazine.new(magazine_params)

    if @magazine.save
      render json: @magazine, status: :created, location: @magazine
    else
      render json: @magazine.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /magazines/1
  def update
    if @magazine.update(magazine_params)
      render json: @magazine
    else
      render json: @magazine.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_magazine
      @magazine = Magazine.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def magazine_params
      params.require(:magazine).permit(:title, :description, :header_image, :color_1, :color_2, :color_3, :color_4, :font_1, :font_2, :top_story, pages_order: [])
    end
end
