class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user  = User.find(params[:id])
    @lists = List.where(user_id: @user.id)
  end

  def destroy
    @user = User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to root_path
  end

  def index
    @user  = User.find(params[:id])
  end
end
