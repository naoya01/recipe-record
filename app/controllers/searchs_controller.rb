class SearchsController < ApplicationController
    def search
   # viewのform_tagにて
    # 選択したmodelの値を@modelに代入。
    @model = params["model"]
    # 選択した検索方法の値を@methodに代入。
    @method = params["method"]
    # 検索ワードを@contentに代入。
    @content = params["content"]
    # @model, @content, @methodを代入した、
    # search_forを@recordsに代入。
    @records = search_for(@model, @content, @method)
  end

  private
  def search_for(model, content, method)
    # 選択したモデルがuserだったら
    if model == 'cooking'
      # 選択した検索方法がが完全一致だったら
      if method == 'perfect'
        Cooking.where(cooking_name: content)
      # 選択した検索方法がが部分一致だったら
      else
        Cooking.where('cooking_name LIKE ?', '%'+content+'%')
      end
    # 選択したモデルがpostだったら
    elsif model == 'post'
      if method == 'perfect'
        Post.where(post_name: content)
      else
        Post.where('post_name LIKE ?', '%'+content+'%')
      end
    end
  end
end
