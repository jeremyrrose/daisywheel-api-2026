class SectionsController < ApplicationController
  before_action :set_section, only: [:show, :update, :destroy]

  # GET /sections
  def index
    @sections = Section.all

    render json: @sections
  end

  # GET /sections/1
  def show
    @section = Section.find(params[:id])
    @top_story = Article.find_by_id(@section.top_story)
    @features = []
    @section.features.each { |feature| @features.push(Article.find_by_id(feature.article_id)) }
    render json: { section: @section, top_story_object: @top_story, features: @features }
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
      params.require(:section).permit(:title, :short_title)
    end
end
