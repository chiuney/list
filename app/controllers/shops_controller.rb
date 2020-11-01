class ShopsController < ApplicationController
  before_action :authenticate_user!

  def new
    @shop = Shop.new
    @list = List.find(params[:id])
  end

  # def create
  #   @shop = Shop.new
  #   @shop.user_id = current_user.id
  #   redirect_to request.referer
  # end

  def show
    @shop = Shop.find(params[:id])
    @add_shop = AddShop.find_by(user_id: current_user.id, shop_id: @shop.id)
  end

  # def index
  #   @user = User.find(params[:id])
  #   @shops = Shop.preload(:list_shops).where(user_id: @user.id)
  #   @add_shop = AddShop.find_by(user_id: current_user.id, shop_id: @shop.id)
  # end

  # def destroy
  #   @shop = Shop.find(params[:id])
  #   @shop.destroy
  #   redirect_to current_user
  # end

  def edit
    @shop = Shop.find(params[:id])
  end

  def update
    @shop = Shop.find(params[:id])

    if params[:shop][:photo_ids]
      params[:shop][:photo_ids].each do |photo_id|
        photo = @shop.photos.find(photo_id)
        photo.purge
      end
    end
    
    if @shop.update(shop_params)
      redirect_to shop_path(@shop)
    else
      render "shops/edit"
    end
  end

  private
    # def shop_params
    #   params.require(:shop).permit(:shop_name, :shop_comment, list_ids: [],photos: [])
    # end
end
