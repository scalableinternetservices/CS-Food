class UsersController < ApplicationController

  def new
    
  end

  def show
    @user = current_user
  end

  def edit

  end
end
