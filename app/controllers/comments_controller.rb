class CommentsController < ApplicationController
  before_action :require_user

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.user = current_user

    if @comment.save
      flash[:notice] = 'comment was successfully created.'
      redirect_to post_path(params[:post_id])
    else
      @post = Post.find(params[:post_id])
      render "posts/show"
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
