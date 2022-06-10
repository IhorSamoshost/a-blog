class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update]
  before_action :require_admin, except: [:index, :show]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 3)
  end

  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 3)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Article category \"#{ @category.name }\" was successfully created!"
      redirect_to @category
    else
      flash[:alert] = "Article category \"#{ @category.name }\" is not created - something went wrong, try again!"
      render "new"
    end
  end

  def edit
  end

  def update
    old_name = @category.name
    if @category.update(category_params)
      flash[:notice] = "Article category name was updated successfully from \"#{ old_name }\" to \"#{ @category.name }\"!"
      redirect_to @category
    else
      flash[:alert] = "Article category \"#{ old_name }\" is not updated - something went wrong, try again!"
      render "edit"
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "Only admins can perform that action"
      redirect_to categories_path
    end
  end
end
