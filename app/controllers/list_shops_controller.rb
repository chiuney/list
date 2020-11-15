class ListShopsController < ApplicationController

  def new
    @shop = Shop.find(params[:shop_id])
    @list_shop = ListShop.new

  end

  def create
    @list_shop = ListShop.new
    @list_shop.shop_id = (params[:shop_id])
    @list_shop.list_id = session[:list_id]
    if @list_shop.save
        flash[:success] = "リストに追加しました。"
        session.delete(:list_id)
        redirect_to shop_path(@list_shop.shop_id)
    else
      redirect_to request.referer
    end
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
