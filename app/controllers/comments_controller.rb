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

  def vote
    if Vote.find_by user_id: current_user.id, voteable_type: "Comment", voteable_id: params[:id]
      flash[:error] = "you've voted!"
      redirect_to post_path(params[:post_id])
    else
      comment = Comment.find(params[:id])
      Vote.create(voteable: comment, creator: current_user, vote: params[:vote])
      flash[:notice] = "vote successfully!"
      redirect_to post_path(params[:post_id])
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
