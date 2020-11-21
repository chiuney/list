class ListShopsController < ApplicationController

  def new
    @shop = Shop.find(params[:shop_id])
    @lists = List.where(@shop.user_id)
  end

  # def create
  #   @list_shop = ListShop.new
  #   @list_shop.shop_id = (params[:shop_id])
  #   @list_shops = params[:list_ids].each do |list_id|
  #     list_shop = ListShop.find(list_id)
  #     if list_shop.save
  #       flash[:success] = "リストに追加しました。"
  #       redirect_to shop_path(@list_shop.shop_id)
  #     else
  #       redirect_to request.referer
  #     end
  #   end
  # end

  def create
    params[:list_ids].each do |list_id|
      ListShop.create!(shop_id: params[:shop_id], list_id: list_id)
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

  private
    def list_shop_params
      params.permit(:shop_name, list_ids: [])
    end
end
