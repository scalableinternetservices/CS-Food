class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new

  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def myfavorites
    @items = Item.where(users_id: current_user.id)
  end
end
