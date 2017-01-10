class V1::MeasurementsController < ApplicationController
  before_action :set_user
  before_action :set_measurement, only: [:show, :destroy]

  def index
    @measurements = @user.measurements
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
  def set_user
    @user = params[:user_id] == 'me' ? @current_user : User.find(params[:user_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_measurement
    @measurement = Measurement.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def measurement_params
    params.require(:measurement).permit(:age, :height, :weight, :activity_level)
  end
end
