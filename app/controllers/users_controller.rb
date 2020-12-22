# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user  = User.find(params[:id])
    @lists = List.preload(:shops).where(user_id: @user.id)
    @shops = Shop.preload(:shops).where(user_id: @user.id)
    @add_shops = AddShop.where(user_id: @user.id)
  end

  def destroy
    @user = User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to root_path
  end

  def index
    @user = User.find(params[:id])
  end

  def following
    @user = User.find(params[:id])
    render 'following'
  end

  def followers
    @user = User.find(params[:id])
    render 'followers'
  end

  def search
    @user_or_list_or_shop = params[:option]
    case @user_or_list_or_shop
    when '1'
      @users = User.search(params[:search], @user_or_list_or_shop).page(params[:page])
    when '2'
      @lists = List.search(params[:search], @user_or_list_or_shop).page(params[:page])

    else
      @shops = Shop.search(params[:search], @user_or_list_or_shop).page(params[:page])
    end
  end
end
