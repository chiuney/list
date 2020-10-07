class ListsController < ApplicationController
  before_action :authenticate_user!

  def index
    
  end

  # def new
  #   @list = List.new
  # end

  # def create
  #   @list = current_user.lists.build(list_params)
  #   if @list.save
  #     redirect_to @list
  #   else
  #     render new_lists_path
  #   end
  # end

  # def show
  #   @list = List.find(params[:id])
  # end

  # def edit
  #   @list = List.find(params[:id])
  # end

  # def update
  #   @list = List.find(params[:id])
  #   if @list.update(list_params)
  #     redirect_to @list
  #   else
  #     render edit_lists_path
  #   end
  # end

  # private
  #   def list_params
  #     params.require(:list).permit(:list_name, :list_comment)
  #   end
end