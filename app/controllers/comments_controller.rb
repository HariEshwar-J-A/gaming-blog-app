class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:destroy]
  before_action :find_comment, only: [:delete]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params.merge(user: current_user))
    if @comment.save
      redirect_to @post, notice: 'Comment was successfully added.'
    else
      redirect_to @post, alert: 'Unable to add comment.'
    end
  end

  def destroy
    @post = @comment.post
    @comment.destroy
    redirect_to post_path(@post), notice: 'Comment was successfully deleted.'
  end

  def delete
    if @comment
      post = @comment.post
      @comment.destroy
      redirect_to post_path(post), notice: 'Comment successfully deleted.'
    else
      redirect_to root_path, alert: 'Unable to find comment.'
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content)
    end

    def find_comment
      @comment = Comment.find_by(id: params[:id])
      if @comment.nil?
        redirect_to root_path, alert: 'Comment not found.'
      end
    end
end
