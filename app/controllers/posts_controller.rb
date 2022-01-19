class PostsController < ApplicationController
  def new
    @post = Post.new
    @flavors = @post.flavors.build
    @foodstuffs = @post.foodstuffs.build
    @recipes = @post.recipes.build
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
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
    @posts = current_user.posts.limit(5)
    @post = Post.find(params[:id])
  end

  def edit
      @post = Post.find(params[:id])
    if @post.user ==! current_user
      redirect_to posts_path
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def update
    @post = Post.find(params[:id])
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
end
