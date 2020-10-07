class ListsController < ApplicationController
  before_action :authenticate_user!

  def new
    @list = FavoriteList.new
  end

  def create
    @list = FavoriteList.new(list_params)
    @list.user_id = current_user.id
    if @list.save
      redirect_to list_path(id: @list.id)
    else
      render new_lists_path
    end
  end

  def show
    @list = FavoriteList.find(params[:id])
  end

  def edit
    @list = FavoriteList.find(params[:id])
  end

  def update
    @list = FavoriteList.find(params[:id])
    if @list.update(list_params)
      redirect_to list_path(id: @list.id)
    else
      render edit_list_path
    end
  end

  private
    def list_params
      params.permit(:list_name, :list_comment)
    end
end