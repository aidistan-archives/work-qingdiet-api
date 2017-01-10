class ApplicationController < ActionController::API
  # API application have to include it explicitly
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  # Add action hooks
  before_action :authenticate_access_token

  private

  # Authenticate access_token in the request
  def authenticate_access_token
    token = Token.find_by(uuid: headers['Authorization'] || params[:access_token])

    if token
      @current_app = token.app
      @current_user = token.user
      @current_token = token

      token.update_attributes(
        last_used_ip: request.remote_ip,
        last_used_at: Time.now
      )
    else
      render body: nil, status: :unauthorized
    end
  end

  def set_user
    @user =
      case (user_id = params[:user_id] || params[:id])
      when 'me' then @current_user
      else User.find(user_id)
      end
  end
end
