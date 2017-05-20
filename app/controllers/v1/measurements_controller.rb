class V1::MeasurementsController < ApplicationController
  before_action :set_measurement, only: %i[show update destroy]

  def index
    @measurements = policy_scope(Measurement).order(created_at: :desc)
  end

  def show
  end

  def create
    authorize @measurement = User.find(params[:user_id] || current_user.id).measurements.build(measurement_params)

    if @measurement.save
      render :show, status: :created
    else
      render json: @measurement.errors, status: :unprocessable_entity
    end
  end

  def update
    if @measurement.update(measurement_params)
      render :show, status: :ok
    else
      render json: @measurement.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @measurement.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_measurement
    authorize @measurement = params[:id] == 'latest' ? current_user.measurements.order(created_at: :desc).limit(1).take : Measurement.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def measurement_params
    params.require(:measurement).permit(:gender, :age, :height, :weight, :activity_level)
  end
end
