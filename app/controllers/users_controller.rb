class UsersController < ApplicationController
  def index
    redirect_to edit_user_registration_path
  end

  # お気に入りページ
  def show
    @cookings = current_user.cookings.page(params[:page]).per(30)
  end

end
