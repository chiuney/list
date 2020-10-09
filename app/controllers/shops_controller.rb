class ShopsController < ApplicationController
  before_action :authenticate_user!

  def new
    @shop = Shop.new
  end

  def create
    @list = FavoriteList.find(params[:list.id])
    @shop = Shop.new(shop_params)
    @shop.user_id = current_user.id
    if @shop.save
      redirect_to list_path(id: @shop.id)
    else
      render new_shop_path
    end
  end

  private
    def shop_params
      params.permit(:shop_name, :shop_comment)
    end
end
