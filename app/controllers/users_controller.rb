class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 3)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the Alf Blog, #{@user.username}! You have successfully signed up!"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Information of user account with id=#{@user.id} was updated successfully!"
      redirect_to @user
    else
      render "edit"
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
