class V1::MeasurementsController < ApplicationController
  before_action :set_user
  before_action :set_measurement, only: [:show, :destroy]

  def index
    @measurements = @user.measurements.order(created_at: :desc)
  end

  def show
  end

  def create
    @measurement = @user.measurements.create(measurement_params)

    if @measurement.save
      render :show, status: :created, location: v1_user_measurement_url(@user, @measurement)
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
    @measurement =
      case params[:id]
      when 'latest' then @user.measurements.order(created_at: :desc).limit(1).take
      else Measurement.find(params[:id])
      end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def measurement_params
    params.require(:measurement).permit(:age, :height, :weight, :activity_level)
  end
end
