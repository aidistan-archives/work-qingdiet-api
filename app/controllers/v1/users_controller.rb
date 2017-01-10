class V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users/1
  def show
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render :show
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # TODO: pend the deletion for 60 days
  def destroy
    @user.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = params[:id] == 'me' ? @current_user : User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.fetch(:user, {})
  end
end
