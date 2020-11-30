class ShopsController < ApplicationController
  before_action :authenticate_user!

  def new
    @shop = Shop.new
    @list = List.find(params[:id])
  end

  def create
    @shop = Shop.new(shop_params)
    @shop.user_id = current_user.id
    if @shop.save
      session.delete(:list_id)
      redirect_to shop_path(@shop.id)
    else
      render "shops/new"
    end
  end

  def show
    @shop = Shop.find(params[:id])
    @list_shop = ListShop.where(shop_id: params[:shop_id], list_id: params[:list_id])
    @add_shop = AddShop.where(user_id: current_user.id)
  end

  def index
    @user = User.find(params[:id])
    @shops = Shop.preload(:list_shops).where(user_id: @user.id)
  end

  def destroy
    @shop = Shop.find(params[:id])
    @shop.destroy
    redirect_to current_user
  end

  def edit 
    @shop = Shop.find(params[:id])
  end

  private
    def shop_params
      params.require(:shop).permit(:shop_name, :shop_comment, list_ids: [],photos: [])
    end
end