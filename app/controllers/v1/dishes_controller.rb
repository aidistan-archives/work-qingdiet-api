class V1::DishesController < ApplicationController
  before_action :set_dish, only: [:show, :update, :destroy]

  def index
    @dishes = Dish.all
  end

  def show
  end

  def create
    authorize @dish = Dish.new(dish_params)

    if @dish.save
      render :show, status: :created
    else
      render json: @dish.errors, status: :unprocessable_entity
    end
  end

  def update
    if @dish.update(dish_params)
      render :show, status: :ok
    else
      render json: @dish.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @dish.destroy
  end

  private

  def set_dish
    authorize @dish = Dish.find(params[:id])
  end

  def dish_params
    params.fetch(:dish, {})
  end
end
