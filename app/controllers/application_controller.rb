class ApplicationController < ActionController::API
  # Include for OAuth authentication
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  # # Include for authorization
  # include Pundit

  before_action :authenticate_access_token

  # rescue_from(Pundit::NotAuthorizedError) { head :unauthorized }

  # # Use current_token instead of current_user
  # def pundit_user
  #   @current_token
  # end

  private

  # Authenticate access_token in the request
  def authenticate_access_token
    token = Token.find_by(
      uuid: headers['Authorization'] || params[:access_token],
      kind: 'access'
    )

    if token && !token.expired?
      @current_app = token.app
      @current_user = token.user
      @current_token = token

      token.update_attributes(last_used_at: Time.now, last_used_ip: request.remote_ip)
    else
      head :unauthorized
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
