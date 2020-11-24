class ListsController < ApplicationController

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id
    if @list.save
      flash[:success] = "リストを追加しました。"
      redirect_to list_path(@list.id)
    else
      render new_list_path
    end
  end

  def show
    @list = List.find(params[:id])
    @list_shop = ListShop.where(list_id: @list.id)
  end

  def edit
    @list = List.find(params[:id])
    @photos = Shop.where(list_id: @list.id)
  end

  def update
    @list = List.find(params[:id])
    if @list.update(list_params)
      redirect_to list_path(id: @list.id)
    else
      render edit_list_path
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to current_user
  end

  private
    def list_params
      params.require(:list).permit(:list_name, :list_comment )
    end
end