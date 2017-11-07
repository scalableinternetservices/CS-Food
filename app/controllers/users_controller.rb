class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new

  end

  def show
    #@user = current_user
    @user = User.find(params[:id])
  end

  def edit

  end
end
