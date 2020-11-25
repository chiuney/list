class ListShopsController < ApplicationController

  def new
    @shop = Shop.find(params[:shop_id])
    @lists = List.where(@shop.user_id)
  end

  def create
    # transaction処理
    ActiveRecord::Base.transaction do
      # eachでshopをlist毎にcreate
      params[:list_ids].each do |list_id|
        ListShop.create!(shop_id: params[:shop_id], list_id: list_id)
      end
        # photosはShopに保存
        shop = Shop.find(params[:shop_id])
        shop.update!(photos: params[:photos], shop_comment: params[:shop_comment])
    end
      flash[:success] = "リストに追加しました。"
      redirect_to user_path(current_user.id)
    rescue => e
      flash[:alert] = e.message
      redirect_to request.referer
  end

  def update
    ActiveRecord::Base.transaction do
      shop = Shop.find(params[:shop_id])
      # photosの削除メソッド
      if params[:photos_ids] # (photosが登録済みの場合)
        params[:photos_ids].each do |photos_id|
          photos = shop.photos.find(photos_id)
          photos.purge
        end
      end
      # eachでshopをlist毎にupdate
      params[:list_ids].each do |list_id| 
        list_shop = ListShop.find_by(shop_id: params[:shop_id])
        list_shop.update!(shop_id: params[:shop_id], list_id: list_id)
      end
      # photosの追加登録
      new_photos = params[:photos].map do |photo|
        ActiveStorage::Blob.create_after_upload! \
                  io: photo.open,
                  filename: photo.original_filename,
                  content_type: photo.content_type
      end
      shop.photos.attach(new_photos)
      shop.update!(shop_comment: params[:shop_comment])
    end
      flash[:success] = "変更しました"
      redirect_to shop_path
    rescue => e
      flash[:alert] = e.message
      redirect_to request.referer
  end

  def destroy
    @shop = Shop.find(params[:shop_id])
    @list_shop = ListShop.find_by(shop_id: @shop.id)
    @list_shop.destroy
    redirect_to request.referer
  end

  def edit 
    @shop = Shop.find(params[:id])
  end

  # private
  #   def list_shop_params
  #     params.require(:list_shop).permit(photos: params[:photos], shop_comment: params[:shop_comment] )
  #   end
end
