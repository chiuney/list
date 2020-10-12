class ShopsController < ApplicationController
  before_action :authenticate_user!

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)
    @shop.user_id = current_user.id
    if @shop.save
      redirect_to list_shop_path
    else
      render "shops/new"
    end
  end

  def show
    @shop = Shop.find_by(id: params[:id])
  end

  def index
    @shops = Shop.all
  end

  private
    def shop_params
      params.require(:shop).permit(:shop_name, :shop_comment)
    end
end
