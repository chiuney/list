class ListsController < ApplicationController

  before_action :set_list, only: [:edit, :update]

  def new
    @list = FavoriteList.new
  end

  def create
    @list = FavoriteList.new(list_params)
    @list.user_id = current_user.id
    if @list.save
      redirect_to list_path(@list.id)
    else
      render :new
    end
  end

  def show
    @list = FavoriteList.find(params[:id])
    @shops = Shop.where(list_id: @list.id)
  end

  def edit
  end

  def update
    if @list.update(list_params)
      redirect_to list_path(id: @list.id)
    else
      render edit_list_path
    end
  end

  def destroy
    @list = FavoriteList.find(params[:id])
    @list.destroy
    redirect_to current_user
  end

  # def set_list
  #   @list = FavoriteList.find(params[:id])
  # end

  private
    def list_params
      params.permit(:list_name, :list_comment)
    end
end