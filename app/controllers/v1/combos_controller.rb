class V1::CombosController < ApplicationController
  before_action :set_combo, only: [:show, :update, :destroy]

  def index
    @combos = policy_scope(Combo)
  end

  def show
  end

  def create
    # TODO: create based on dishes and a requirement
    authorize @combo = User.find(params[:user_id] || current_user.id).combos.build(combo_params)

    if @combo.save
      render :show, status: :created
    else
      render json: @combo.errors, status: :unprocessable_entity
    end
  end

  # def update
  #   if @combo.update(combo_params)
  #     render :show, status: :ok
  #   else
  #     render json: @combo.errors, status: :unprocessable_entity
  #   end
  # end

  def destroy
    @combo.destroy
  end

  private

  def set_combo
    authorize @combo = Combo.find(params[:id])
  end

  def combo_params
    params.require(:combo).permit(:order_id, :requirement_id)
  end
end
