class ShopsController < ApplicationController
  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)
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
