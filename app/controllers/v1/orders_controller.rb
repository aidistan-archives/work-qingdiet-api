class V1::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]

  def index
    @orders = policy_scope(Order)
  end

  def show
  end

  def create
    authorize @order = User.find(params[:user_id] || current_user.id).orders.build(order_params)

    if @order.save
      render :show, status: :created
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def update
    if @order.update(order_params)
      render :show, status: :ok
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy
  end

  private

  def set_order
    authorize @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:status)
  end
end
