class UsersController < ApplicationController
  def index
  end

  # お気に入りページ
  def show
    @cookings = current_user.cookings.page(params[:page]).per(30)
  end

  def edit
  end
end
