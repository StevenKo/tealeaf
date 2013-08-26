class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update,:vote]
  before_action :require_user, only: [:new, :create, :edit, :update]
  before_action :require_creator, only: [:edit, :update]
  
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
    binding.pry
    Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
    flash[:notice] = "vote successfully!"
    redirect_to posts_path
  end

  private
    def post_params
      params.require(:post).permit(:title,:url,:description)
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def require_creator
      access_denied if @post.creator != current_user
    end
end
