class AddShopsController < ApplicationController

  def new
    @add_shop = AddShop.new
  end

  def create
    @shop = Shop.find(params[:shop_id])
    @add_shop = AddShop.create(user_id: current_user.id, shop_id: @shop.id)
    redirect_to request.referer
  end

  def destroy
    @shop = Shop.find(params[:id])
    @add_shop = AddShop.find_by(user_id: current_user.id, shop_id: @shop.id)
    @add_shop.destroy
    redirect_to request.referer
  end

  def index
    @add_shops = AddShop.where(user_id: current_user.id)
  end
end
