class UsersController < ApplicationController
  def index
  end

  def show
    @cookings = current_user.cookings.page(params[:page]).per(30)
  end

  def edit
  end
end
