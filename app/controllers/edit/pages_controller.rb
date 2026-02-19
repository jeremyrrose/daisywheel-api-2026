class Edit::PagesController < ApplicationController
    before_action :set_feature, only: [:destroy]
  
    # GET /pages
    def index
      puts 'halp'
      @pages = Article.where("static_page = true")
      render json: @pages
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_page
        @page = Article.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def page_params
        params.require(:page).permit(:article_id, :title)
      end
  end
  