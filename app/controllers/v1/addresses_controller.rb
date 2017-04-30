class V1::AddressesController < ApplicationController
  before_action :set_address, only: [:show, :update, :destroy]

  def index
    @addresses = policy_scope(Address).order(last_used_at: :desc)
  end

  def show
  end

  def create
    authorize @address = User.find(params[:user_id] || current_user.id).addresses.build(address_params)

    if @address.save
      render :show, status: :created
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  def update
    if @address.update(address_params)
      render :show, status: :ok
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @address.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_address
    authorize @address = Address.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def address_params
    params.require(:address).permit(
      :consignee, :mobile,
      :province, :city, :district, :town, :detail
    )
  end
end
