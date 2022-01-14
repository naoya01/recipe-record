class UsersController < ApplicationController
  def index
  end

  def show
    @user = current_user
    @cookings = current_user.cookings
  end

  def edit
  end
end
