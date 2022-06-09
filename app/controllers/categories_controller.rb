class CategoriesController < ApplicationController
  def index

  end

  def show

  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category #{ @category.name } was successfully created!"
      redirect_to @category
    else
      flash[:alert] = "Category is not created - something went wrong, try again!"
      render "new"
    end
  end

  private

  def set_category
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
