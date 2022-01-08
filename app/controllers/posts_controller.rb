class PostsController < ApplicationController
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
  end

  def show
    @post = Post.find_by(params[:id])
  end

  def edit
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
