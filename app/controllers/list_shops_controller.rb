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
      shop.update!(photos: params[:photos])
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
      
      add_list_shop = params[:list_ids].each do |list_id|
        list_shop = ListShop.find_by(shop_id: params[:shop_id])
      end
      add_list_shop.save!(shop_id: params[:shop_id], list_id: params[:list_id])

      # photosの削除メソッド
      if params[:photos_ids] # photosが登録済みの場合
        params[:photos_ids].each do |photos_id|
          photos = ActiveStorage::Attachment.find(photos_id)
          # purge_later(非同期削除)(purgeだと処理が遅くなる)
          photos.purge_later
        end
      end
      
      # photosの追加登録
      # 詳細→https://api.rubyonrails.org/classes/ActiveStorage/Blob.html#method-c-generate_unique_secure_token
      if params[:photos].present? #エラー回避(.map for nil:NilClass)
        new_photos = params[:photos].map do |photo|
          ActiveStorage::Blob.create_and_upload! \
                    io: photo.open,
                    filename: photo.original_filename,
                    content_type: photo.content_type
        end
        shop.photos.attach(new_photos)
        shop.update!(id: params[:shop_id])
      end
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
