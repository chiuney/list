# frozen_string_literal: true

class ListShopsController < ApplicationController
  before_action :shop_find

  def new
    @list = List.where(user_id: current_user.id)
  end

  def create
    # transaction処理
    ActiveRecord::Base.transaction do
      # eachでshopをlist毎にcreate
      params[:list_ids].each do |list_id|
        ListShop.create!(shop_id: params[:shop_id], list_id: list_id)
      end

      # @shopの写真を追加
      @shop.upload_photos(params[:photos]) if params[:photos].present?
    end
    flash[:success] = 'リストに追加しました。'
    redirect_to shop_path(id: @shop.id)
  rescue StandardError => e
    flash[:alert] = e.message
    redirect_to shop_new_list_shops_path
  end

  def edit
    @list = List.where(user_id: current_user.id)
  end

  def update
    # 写真の追加
    @shop.photos.attach(params[:photos]) if params[:photos].present?

    # photosの削除
    # photosが登録済みの場合
    params[:photos_ids]&.each do |photos_id|
      photos = ActiveStorage::Attachment.find(photos_id)
      photos.purge_later # purge_later(非同期削除)(purge = 同期削除 だと処理が遅くなる)
    end

    if @shop.update(shop_params)
      flash[:success] = '変更しました'
      redirect_to shop_path
      return
    end
    flash[:alert] = e.message
    redirect_to request.referer
  end

  def destroy
    @list_shop = ListShop.find_by(shop_id: @shop.id)
    @list_shop.destroy
    redirect_to request.referer
  end

  private

  def shop_params
    params.permit(:shop, list_ids: [])
  end

  def shop_find
    @shop = Shop.find(params[:shop_id])
  end
end
