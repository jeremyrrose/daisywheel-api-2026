class Edit::FeaturesController < ApplicationController
    before_action :set_feature, only: [:destroy]
  
    # GET /features
    def index
      puts 'halp'
      @features = Feature.where("section_id IS NULL")
      render json: @features
    end

    # POST /features
    def create
      @feature = Feature.new(feature_params)
  
      if @feature.save
        render json: @feature, status: :created
      else
        render json: @feature.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /features/1
    def destroy
      @feature.destroy
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_feature
        @feature = Feature.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def feature_params
        params.require(:feature).permit(:section_id, :article_id, :priority)
      end
  end
  