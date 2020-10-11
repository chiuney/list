class ShopsController < ApplicationController
  before_action :authenticate_user!

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)
    @shop.user_id = current_user.id
    if @shop.save
      session.delete(:favorite_list_id)
      redirect_to current_user
    else
      render new_shop_path
    end
  end

  def index
    @shops = Shop.all
  end

  private
    def shop_params
      params.require(:shop).permit(:shop_name, :shop_comment)
    end
end
