class Front::SectionsController < ApplicationController
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
    
        if @section.top_story
            @top_story = Article.find_by_id(@section.top_story)
            pub_date = @top_story.created_at.month.to_s.rjust(2, '0') + '-' + @top_story.created_at.mday.to_s.rjust(2, '0') + '-' + @top_story.created_at.year.to_s
            @top_story.write_attribute(:publication_date, pub_date)
            if @top_story.image.attached?
                @top_story.write_attribute(:image_url, url_for(@top_story.image.variant(resize_to_limit: [1800, 1800]).processed))
            end
        end

        if @section.features[0]
            @features = []
            @section.features.each { |feature| @features.push(Article.find_by_id(feature.article_id)) }
            @features.each do |article|
                pub_date = article.created_at.month.to_s.rjust(2, '0') + '-' + article.created_at.mday.to_s.rjust(2, '0') + '-' + article.created_at.year.to_s
                article.write_attribute(:publication_date, pub_date)
                if article.image.attached?
                article.write_attribute(:image_url, url_for(article.image.variant(resize_to_limit: [1200, 1200]).processed))
                end
                if article.author
                article.write_attribute(:author, {name: article.author.name})
                end
            end
        end

      @articles = Article.with_attached_image.select(:id,:url,:title,:dek,:author_id,:created_at).where("section_id = ?",params[:id]).where("static_page = false").order("id DESC").limit(12)  
      @articles.each do |article|
        pub_date = article.created_at.month.to_s.rjust(2, '0') + '-' + article.created_at.mday.to_s.rjust(2, '0') + '-' + article.created_at.year.to_s
        article.write_attribute(:publication_date, pub_date)
        if article.image.attached?
          article.write_attribute(:image_url, url_for(article.image.variant(resize_to_limit: [800, 800]).processed))
        end
        if article.author
          article.write_attribute(:author, {name: article.author.name})
        end
      end
  
      render json: { section: @section, top_story_object: @top_story, features: @features, articles: @articles }
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
  