# app/controllers/api/v1/comments_controller.rb
module Api
  module V1
    class CommentsController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :set_post, only: [:create]
      before_action :set_comment, only: [:destroy]

      def create
        comment = @post.comments.new(comment_params.merge(user: current_user))  # Assumes current_user is set
        if comment.save
          render json: comment, status: :created
        else
          render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @comment.destroy
          head :no_content
        else
          render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_post
        @post = Post.find(params[:post_id])
      end

      def set_comment
        @comment = Comment.find(params[:id])
      end

      def comment_params
        params.require(:comment).permit(:body)
      end
    end
  end
end
