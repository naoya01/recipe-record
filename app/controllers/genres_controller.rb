class GenresController < ApplicationController
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.user_id = current_user.id
    if @genre.save
      redirect_to genre_path(@genre.id)
    else
      redirect_to genres_path
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to genres_path
  end

  def edit
    @genre = Genre.find_by(params[:id])
    if @genre.user == current_user
      render "edit"
    else
      redirect_to genres_path
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:genre_name,:user_id,:cooking_id)
  end
end
