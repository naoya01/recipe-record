class MealsController < ApplicationController
  before_action :set_meal, only: %i[ show edit update destroy ]
  before_action :mealtime_judge, only: %i[ update edit ]
  # GET /meals or /meals.json
  def index
    @meals = current_user.meals
    # 全体ランキング
    @genres = Genre.left_joins(:cookings).where(id: 1..13, cookings: { user_id: current_user.id}).group(:genre_id).order('count(genre_id) desc').limit(5)
    # 今月のランキング
    @genres_month = Genre.left_joins(cookings: :meal).where(id: 1..13, cookings: { user_id: current_user.id} ,meals: {date: Date.current.all_month}).group(:genre_id).order('count(genre_id) desc').limit(5)
    # 今週のランキング
    @genres_week = Genre.left_joins(cookings: :meal).where(id: 1..13, cookings: { user_id: current_user.id} ,meals: {date: Date.current.all_week}).group(:genre_id).order('count(genre_id) desc').limit(5)


    # 全体の割合
    @genres_bar = Genre.all.limit(13)
    # 今月の割合
    @genres_bar_month = Genre.left_joins(cookings: :meal).where(cookings: { user_id: current_user.id} ,meals: {date: Date.current.all_month}).includes(genre_name: nil).group(:genre_id).limit(13)
    # 先月の割合
    @genres_bar_lastmonth = Genre.joins(cookings: :meal).where(cookings: { user_id: current_user.id} ,meals: {date: Date.current.last_month.all_month}).group(:genre_id).limit(13)

    # 今週の割合
     @genres_bar_week = Genre.left_joins(cookings: :meal).where(cookings: { user_id: current_user.id} ,meals: {date: Date.current.all_week}).group(:genre_id).limit(13)
    # 先週の割合
    @genres_bar_lastweek = Genre.left_joins(cookings: :meal).where(cookings: { user_id: current_user.id} ,meals: {date: Date.current.last_week.all_week}).group(:genre_id).limit(13)
  end

  # GET /meals/1 or /meals/1.json
  def show
    @meal = Meal.find(params[:id])
    @meals = current_user.meals
    @cookings = current_user.cookings
    @genres = Genre.all
  end

  # GET /meals/new
  def new
    @meal = Meal.new
    # cocoonで料理とジャンルを同時保存のために記述
    @cookings = @meal.cookings.build
    @tags = @cookings.tags.build

  end

  # GET /meals/1/edit
  def edit
  end

  # POST /meals or /meals.json
  def create
    @meal = Meal.new(meal_params)
    @meal.user_id = current_user.id
    # 送信ミスした際にrenderでnewページに遷移さsれた時に日本語になってしまうため英語になるように再定義(ストロングパラメーターに記載)
    mealtime_judge
    at_dates = Meal.where(date: @meal.date, user_id: current_user.id).pluck(:mealtime)
    # dateにデータが入っていないか、同じ日に３回以内投稿されている
    unless at_dates.include?(@meal.mealtime)
      respond_to do |format|
        if @meal.save
            format.html { redirect_to meal_url(@meal), notice: "Meal was successfully created." }
            format.json { render :new, status: :created, location: @meal }
        else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @meal.errors, status: :unprocessable_entity }
        end
      end
    else

    #すでに登録している日付を登録しようとしたとき表示させる
    if @meal.mealtime == "breakfast"
      flash[:failure] = "#{@meal.date}の朝食はすでに登録済みです"
    elsif @meal.mealtime == "lunch"
      flash[:failure] = "#{@meal.date}の昼食はすでに登録済みです"
    else
      flash[:failure] = "#{@meal.date}の夕食はすでに登録済みです"
    end
    redirect_to new_meal_path
    end
  end

  # PATCH/PUT /meals/1 or /meals/1.json
  def update
    @meal.user_id = current_user.id
    # 送信ミスした際にrenderでnewページに遷移さsれた時に日本語になってしまうため英語になるように再定義(ストロングパラメーターに記載)
    mealtime_judge
      respond_to do |format|
        if @meal.update(meal_edit_params)
          format.html { redirect_to meal_url(@meal), notice: "Meal was successfully updated." }
          format.json { render :show, status: :ok, location: @meal }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @meal.errors, status: :unprocessable_entity }
        end
      end

  end

  # DELETE /meals/1 or /meals/1.json
  def destroy
    @meal.destroy
    respond_to do |format|
      format.html { redirect_to meals_url, notice: "Meal was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # カレンダーの下にクリックしたら表示させる機能のために日付のデータを取得
  def day
    meals = Meal.joins(:cookings).select("meals.id,mealtime, title, meal_description, cookings.cooking_name ,cookings.url ,cookings.user_id").where(date: params[:day],user_id: current_user.id )
    render json: meals
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # 日本語を英語に変換
    #　管理者とログインしたユーザのみ実行できるように設定、自分以外のユーザの作ったページに行こうとするとカレンダーページに遷移する
    def set_meal
      @meal = Meal.find(params[:id])
      if @meal.mealtime == "朝"
        @meal.mealtime = "breakfast"
      elsif @meal.mealtime == "昼"
        @meal.mealtime = "lunch"
      elsif @meal.mealtime == "夜"
        @meal.mealtime = "dinner"
      end
      unless  @meal.user_id == current_user.id || current_user.admin == true
        redirect_to meals_path
      end
    end

    # Only allow a list of trusted parameters through.
    def meal_params
      params.require(:meal).permit(:title, :meal_description, :date, :mealtime,:start_date,:end_date,:_destroy,
        cookings_attributes: [:id, :cooking_name,:url,:user_id, :_destroy,
        tags_attributes: [:id, :genre_id, :_destroy]
         ])
    end

    # 編集の際に日付と食事時間のデータを送らないことでバリデーとに引っ掛からないように設定
    def meal_edit_params
      params.require(:meal).permit(:title, :meal_description, :date,:_destroy,
        cookings_attributes: [:id, :cooking_name,:url,:user_id, :_destroy,
        tags_attributes: [:id, :genre_id, :_destroy]
         ])
    end

    # 登録の際入力ミスしてしまった時にrenderで飛ばすため日本語で登録したものを英語に直して
    def mealtime_judge
      if @meal.mealtime == "朝"
        @meal.mealtime = "breakfast"
      elsif @meal.mealtime == "昼"
        @meal.mealtime = "lunch"
      elsif @meal.mealtime == "夜"
        @meal.mealtime = "dinner"
      end
    end
end
