class Front::ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :update, :destroy]
  
    # GET /articles
    def index
      @articles = Article.where('published = true').order("id DESC")
  
      render json: @articles
    end
  
    # GET /articles/1
    def show
        pub_date = @article.created_at.month.to_s.rjust(2, '0') + '-' + @article.created_at.mday.to_s.rjust(2, '0') + '-' + @article.created_at.year.to_s
        @article.write_attribute(:publication_date, pub_date)
        if @article.image.attached?
          @image_url = url_for(@article.image.variant(resize_to_limit: [1800, 1800]).processed)
        else
          @image_url = nil
        end
        if @article.section_id 
          @article.write_attribute(:section_title, Section.find(@article.section_id).title)
        end
        @article.write_attribute(:image_url, @image_url)
        # render json: { article: @article, image_url: @image_url} 
        render json: @article
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_article
        @article = Article.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def article_params
        params.require(:article).permit(:author_id, :section_id, :title, :dek, :content, :image, :caption, :credit, :url, :published, :static)
      end
  end
  