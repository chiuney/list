class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: [:edit, :update, :show]

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

  def set_list
    @list = FavoriteList.find(params[:id])
  end

  private
    def list_params
      params.permit(:list_name, :list_comment)
    end
end