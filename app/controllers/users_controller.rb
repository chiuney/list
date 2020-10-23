class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user  = User.find(params[:id])
    @lists = List.preload(:shops).where(user_id: @user.id)
  end

  def destroy
    @user = User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to root_path
  end

  def index
    @user  = User.find(params[:id])
  end

  def following
    @user = User.find(params[:id])
    render "following"
  end

  def followers
    @user = User.find(params[:id])
    render 'followers'
  end

  def search
    @user_or_list = params[:option]
    if @user_or_list == "1"
      @users = User.search(params[:search], @user_or_list)
    else
      @lists = List.search(params[:search], @user_or_list)
    end
  end
end
