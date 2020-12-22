# frozen_string_literal: true

class AddShopsController < ApplicationController
  def create
    @shop = Shop.find(params[:shop_id])
    @add_shop = AddShop.create(user_id: current_user.id, shop_id: @shop.id)
    redirect_to @shop
  end

  def destroy
    @shop = Shop.find(params[:shop_id])
    @add_shop = AddShop.find_by(user_id: current_user.id, shop_id: @shop.id)
    @add_shop.destroy
    redirect_to @shop
  end

  def index
    @add_shops = AddShop.where(user_id: current_user.id)
  end

  def show
    @add_shop = AddShop.find(params[:shop_id])
  end
end
