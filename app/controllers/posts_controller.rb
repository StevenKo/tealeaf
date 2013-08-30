class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update,:vote]
  before_action :require_user, only: [:new, :create, :edit, :update]
  before_action :require_creator_or_admin, only: [:edit, :update]
  
  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def edit
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end


  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def vote
    if Vote.find_by user_id: current_user.id, voteable_type: "Post", voteable_id: params[:id]
      flash[:error] = "you've voted!"      
    else
      Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
      flash[:notice] = "vote successfully!"
    end

    respond_to do |format|
      format.html do
        redirect_to posts_path
      end
      format.js do
        @obj = @post
        render 'shared/vote'
      end
    end
  end

  private
    def post_params
      params.require(:post).permit(:title,:url,:description)
    end

    def set_post
      @post = Post.find_by(slug: params[:id])
    end

    def require_creator_or_admin
      access_denied if (@post.creator != current_user && !current_user.admin?)
    end
end
