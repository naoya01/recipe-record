class FavoritesController < ApplicationController
  def index
  end

  def show
    @user = current_user
    @favorites = current_user.favorites
  end

  def create
    @cooking = Cooking.find(params[:cooking_id])
    favorite = current_user.favorites.new(cooking_id: @cooking.id)
    favorite.save

    # redirect_to request.referer
  end

  def destroy
    @cooking = Cooking.find(params[:cooking_id])
    favorite = current_user.favorites.find_by(cooking_id: @cooking.id)
    favorite.destroy

    # redirect_to request.referer

  end
end
