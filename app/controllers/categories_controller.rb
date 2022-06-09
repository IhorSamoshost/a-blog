class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]
  def index
    @categories = Category.paginate(page: params[:page], per_page: 3)
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
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
