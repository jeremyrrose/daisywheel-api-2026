class Front::MagazinesController < ApplicationController
    before_action :set_magazine, only: [:show, :update, :destroy]
    include Rails.application.routes.url_helpers
  
    # GET /magazines
    def index
      @magazine = Magazine.find(1)
      @magInfo = {
          title: @magazine.title,
          description: @magazine.description,
          colors: {
              color_1: @magazine.color_1,
              color_2: @magazine.color_2,
              color_3: @magazine.color_3,
              color_4: @magazine.color_4
          }
      }

      @menu_sections = []

      @sections = Section.all
      @sections.each do |section|
        @singleSection = { 
            title: section.title,
            short_title: section.short_title,
            url: section.id
        }
        @menu_sections.push(@singleSection)
      end

      @menu_pages = []

      @pages = Article.find(@magazine.pages_order)
      @pages.each do |page|
        @singlePage = {
            title: page.title,
            url: page.id
        }
        @menu_pages.push(@singlePage)
      end

      @menu = {
          sections: @menu_sections,
          pages: @menu_pages
      }

      @page_sections = []
      @used_ids = []

      @top_articles = [ 
        Article.with_attached_image.find(@magazine.top_story)
        ]
      
      @top_feature_ids = Feature.where("section_id IS NULL").limit(3)
        if @top_feature_ids
            @top_feature_ids.each { |feature| @top_articles.push(Article.select(:id,:url,:title,:dek,:author_id, :created_at).find(feature.article_id)) }
        end

      @top_articles.each do |article|
        if article.image.attached?
          article.write_attribute(:image_url, url_for(article.image))
        end
        pub_date = article.created_at.month.to_s.rjust(2, '0') + '-' + article.created_at.mday.to_s.rjust(2, '0') + '-' + article.created_at.year.to_s
        article.write_attribute(:publication_date, pub_date)
      end

      @top_section = {
          title: "Top Stories",
          type: "feature",
          articles: @top_articles          
      }

      @page_sections.push(@top_section)

      @latest = {
          title: "Latest Stories",
          type: "list",
          articles: Article.select(:id,:url,:title,:dek,:author_id,:created_at).where("published = true").order("id DESC").limit(8)
      }

      @latest[:articles].each do | article |
        pub_date = article.created_at.month.to_s.rjust(2, '0') + '-' + article.created_at.mday.to_s.rjust(2, '0') + '-' + article.created_at.year.to_s
        article.write_attribute(:publication_date, pub_date)
      end

      @page_sections.push(@latest)

      @sections.each do |section|
        @featured = []
        if section.top_story 
            @featured.push(Article.find(section.top_story))
            @used_ids.push(section.top_story)
        end
        @feature_ids = Feature.where("section_id = ?",section.id).limit(3)
        if @feature_ids
            @feature_ids.each { |feature| @featured.push(Article.select(:id,:url,:title,:dek,:author_id,:created_at).find(feature.article_id)) }
        end
        @featured.each do |article|
          pub_date = article.created_at.month.to_s.rjust(2, '0') + '-' + article.created_at.mday.to_s.rjust(2, '0') + '-' + article.created_at.year.to_s
          article.write_attribute(:publication_date, pub_date)
          if article.image.attached?
            article.write_attribute(:image_url, url_for(article.image))
          end
        end
        @section_info = {
            title: section.title,
            type: "feature",
            articles: @featured
        }
        if @featured.length > 0
            @page_sections.push(@section_info)
        end
      end
 
      render json: { configuration: @magInfo, menu: @menu, sections: @page_sections }
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
  