class MealsController < ApplicationController
  before_action :set_meal, only: %i[ show edit update destroy ]

  # GET /meals or /meals.json
  def index
    @meals = Meal.all
  end

  # GET /meals/1 or /meals/1.json
  def show
  end

  # GET /meals/new
  def new
    @meal = Meal.new
    @cooking = @meal.cookings.build
  end

  # GET /meals/1/edit
  def edit
  end

  # POST /meals or /meals.json
  def create
    @meal = Meal.new(meal_params)
    @meal.user_id = current_user.id
    respond_to do |format|
      if @meal.save
        format.html { redirect_to meal_url(@meal), notice: "Meal was successfully created." }
        # format.json { render :json => @meal, :status => :created, :location => @meal }
        # format.json { render :"meal/index", status: :created, location: @meal }
        format.json { render :new, status: :created, location: @meal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meal_params
      params.require(:meal).permit(:title, :meal_description, :date, :mealtime,:start_date,:end_date,
        flavors_attributes: [:id, :flavor_name,:flavor_quantity, :_destroy,],
      )
    end

end
