class CategoriesController < ApplicationController
  
  before_action :set_category, only: [:show, :edit]
  before_action :require_admin, only: [:new]

  def index
    @categories = Category.all
  end

  def show
  end

  def edit
  end

  def new
    @category = Category.new
  end

  def create
    # binding.pry
    @category = Category.new(category_params)

    if @category.save
      redirect_to @category, notice: 'category was successfully created.'
    else
      render :new
    end
  end


  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to @category, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  private
    def category_params
      params.require(:category).permit(:name)
    end

    def set_category
      @category = Category.find_by(slug: params[:id])
    end
end
