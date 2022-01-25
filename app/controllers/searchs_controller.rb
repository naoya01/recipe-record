class SearchsController < ApplicationController
  def search
   # viewのform_tagにて
    # 選択したmodelの値を@modelに代入。
    @model = params["model"]
    # 選択した検索方法の値を@methodに代入。
    # 検索ワードを@contentに代入。
    @content = params["content"]
    # @model, @contentを代入した、
    # search_forを@recordsに代入。
    @records = search_for(@model, @content)
  end

  private
  def search_for(model, content)
    # 選択したモデルがcookingだったら
    if model == 'cooking'
      Cooking.where('cooking_name LIKE ?', '%'+content+'%').where(user_id: current_user.id).page(params[:page]).per(1)
    # 選択したモデルがpostだったら
    elsif model == 'post'
      Post.where('post_name LIKE ?', '%'+content+'%').where(user_id: current_user.id).page(params[:page]).per(1)
    end
  end
end
