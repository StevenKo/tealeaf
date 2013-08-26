class CategoriesController < ApplicationController
  
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
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
end
