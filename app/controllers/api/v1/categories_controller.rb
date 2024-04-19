# app/controllers/api/v1/categories_controller.rb
module Api
  module V1
    class CategoriesController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        categories = Category.all
        render json: categories
      end

      def show
        category = Category.find(params[:id])
        render json: category
      end
    end
  end
end
