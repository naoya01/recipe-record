class GenresController < ApplicationController
  before_action :user_admin, only: [:edit,:destroy,:create,:update]
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def show
    @genre = Genre.find(params[:id])
    @cookings = Cooking.joins(:tags).where(tags: { genre_id: @genre.id }, user_id: current_user.id).page(params[:page]).per(10)

  end

  def create
    @genre = Genre.new(genre_params)
    @genre.user_id = current_user.id
    if @genre.save
      @genres = Genre.all
      render :index
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
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to genres_path
    else
      render "edit"
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:genre_name,:user_id,:cooking_id)
  end

  def user_admin #% 管理者に権限を与えている
     if  current_user.admin == false
         redirect_to meals_path
     end
  end
end
