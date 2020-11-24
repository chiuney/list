class ListShopsController < ApplicationController

  def new
    @shop = Shop.find(params[:shop_id])
    @lists = List.where(@shop.user_id)
  end

  def create
    params[:list_ids].each do |list_id|
      ListShop.create!(shop_id: params[:shop_id], list_id: list_id, photos: params[:photos])
    end
      flash[:success] = "リストに追加しました。"
      redirect_to user_path(current_user.id)
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

  # private
  #   def list_shop_params
  #     params.permit(list_ids: [], photos: [])
  #   end
end
