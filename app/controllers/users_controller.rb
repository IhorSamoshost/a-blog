class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def new
    @user = User.new
  end

  private

  def set_user
    @article = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email)
  end
end