# app/controllers/api/v1/posts_controller.rb
module Api
  module V1
    class PostsController < ApplicationController
      include Authenticable
      skip_before_action :verify_authenticity_token
      before_action :authenticate_user!, only: [:create, :update, :destroy]
      before_action :set_post, only: [:show, :update, :destroy]

      def index
        posts = Post.all
        render json: posts
      end

      def show
        render json: @post
      end

      def create
        Rails.logger.debug "Received params: #{params.inspect}"  # Log incoming parameters
        @post = current_user.posts.build(post_params)
        if @post.save
          render json: @post, status: :created, location: api_v1_post_url(@post)
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      def update
        if @post.update(post_params)
          render json: @post
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @post.destroy
        head :no_content
      end

      private

      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:title, :content, :categories, :user_id)  # Assuming posts belong to a user
      end
    end
  end
end
