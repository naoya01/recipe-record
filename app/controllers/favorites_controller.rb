class FavoritesController < ApplicationControllers

  def create
    @cooking = Cooking.find(params[:cooking_id])
    favorite = current_user.favorites.new(cooking_id: @cooking.id)
    favorite.save
  end

  def destroy
    @cooking = Cooking.find(params[:cooking_id])
    favorite = current_user.favorites.find_by(cooking_id: @cooking.id)
    favorite.destroy
  end
end
