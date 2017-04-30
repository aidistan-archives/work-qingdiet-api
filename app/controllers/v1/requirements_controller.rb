class V1::RequirementsController < ApplicationController
  before_action :set_requirement, only: %i[show update destroy]

  def index
    @requirements = policy_scope(Requirement)
  end

  def show
  end

  def create
    authorize @requirement = Requirement.new(requirement_params)

    if @requirement.save
      render :show, status: :created
    else
      render json: @requirement.errors, status: :unprocessable_entity
    end
  end

  def update
    if @requirement.update(requirement_params)
      render :show, status: :ok
    else
      render json: @requirement.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @requirement.destroy
  end

  private

  def set_requirement
    authorize @requirement = Requirement.find(params[:id])
  end

  def requirement_params
    params.require(:requirement).permit(:purpose, :measurement_id)
  end
end
