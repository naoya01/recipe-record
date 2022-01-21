class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  def new
    @post = Post.new
    @flavors = @post.flavors.build
    @foodstuffs = @post.foodstuffs.build
    @recipes = @post.recipes.build
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def index
    @posts = current_user.posts.page(params[:page]).per(40)
  end

  def show
    @posts = Post.where(user_id: @post.user_id)
    unless  @post.user_id == current_user.id || current_user.admin == true
      redirect_to meals_path
    end
  end

  def edit
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render "edit"
    end
  end

  private
  def post_params
        params.require(:post).permit(:post_name, :post_description, :post_image, :quantity,
        flavors_attributes: [:id, :flavor_name,:flavor_quantity, :_destroy,],
        foodstuffs_attributes: [:id, :foodstuff_name,:foodstuff_quantity, :_destroy,],
        recipes_attributes: [:id, :recipe_description,:recipe_image, :_destroy,],
        )
  end

  def set_post
    @post = Post.find(params[:id])
    unless  @post.user_id == current_user.id || current_user.admin == true
      redirect_to meals_path
    end
  end
end
