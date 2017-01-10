class V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def show
  end

  def update
    if @user.update(user_params)
      render :show, status: :ok, location: v1_user_url(@user)
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # TODO: pend the deletion for 60 days
  def destroy
    @user.destroy
  end

  private

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.fetch(:user, {})
  end
end
