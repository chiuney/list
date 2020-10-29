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
      redirect_to list_path(id: @shop.list_id)
    else
      logger.debug @shop.errors.inspect
      render "shops/new"
    end
  end

  def show
    @shop = Shop.find(params[:id])
    @user = User.find_by(id: @shop.user_id)
    @list = List.find_by(id: @shop.list_id)
  end

  def index
    @user = User.find(params[:id])
    @shops = Shop.where(user_id: @user.id)
  end

  def destroy
    @shop = Shop.find(params[:id])
    @shop.destroy
    redirect_to list_path(@shop.list_id)
  end

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
    def shop_params
      params.require(:shop).permit(:shop_name, :shop_comment, :list_id,photos: [])
    end
end
