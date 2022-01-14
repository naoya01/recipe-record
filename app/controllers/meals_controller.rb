class MealsController < ApplicationController
  before_action :set_meal, only: %i[ show edit update destroy ]

  # GET /meals or /meals.json
  def index
    @meals = current_user.meals
    @genres = Genre.joins(:cookings).where(cookings: { user_id: current_user.id}).group(:genre_id).order('count(genre_id) desc').limit(5)
    # @genres_month = Genre.joins(:cookings,:meals).where(cookings: { user_id: current_user.id} ,meals: {date: Date.current.all_month}).group(:genre_id).order('count(genre_id) desc').limit(5)
    @all_ranks = Genre.find(Tag.group(:genre_id).order('count(genre_id) desc').limit(9).pluck(:genre_id))
    # @genre_ranks = Cooking.find(Tag.group(:genre_id).order('count(genre_id) desc').pluck(:genre_id))
    # binding.pry
  end

  # GET /meals/1 or /meals/1.json
  def show
    @meals = current_user.meals
    @cookings = current_user.cookings
    @genres = Genre.all
  end

  # GET /meals/new
  def new
    @meal = Meal.new
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
    # @meal.cookings.user_id = current_user.id
    # at_dates = Meal.where(date: @meal.date).select("mealtime: @meal.mealtime")
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
    flash[:notice] = "その日の時間はすでに登録済みです"
    render :new
    end
  end

  # PATCH/PUT /meals/1 or /meals/1.json
  def update
    @meal.user_id = current_user.id

      respond_to do |format|
        if @meal.update(meal_params)
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

  def day
    meals = Meal.joins(:cookings).select("meals.id,mealtime, title, meal_description, cookings.cooking_name ,cookings.url ,cookings.user_id").where(date: params[:day],user_id: current_user.id )
    render json: meals
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meal_params
      params.require(:meal).permit(:title, :meal_description, :date, :mealtime,:start_date,:end_date,:_destroy,
        cookings_attributes: [:id, :cooking_name,:url,:user_id, :_destroy,
        tags_attributes: [:id, :genre_id, :_destroy]
         ])
    end

end