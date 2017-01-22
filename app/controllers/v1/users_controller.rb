class V1::UsersController < ApplicationController
  before_action :set_user, except: :index

  def index
    @users = policy_scope(User)
  end

  def show
  end

  # def create
  # end

  def update
    if @user.update(user_params)
      render :show, status: :ok, location: v1_user_url(@user)
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # def destroy
  #   @user.destroy
  # end

  private

  def set_user
    authorize @user = params[:id] == 'me' ? current_user : User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.fetch(:user, {})
  end
end
