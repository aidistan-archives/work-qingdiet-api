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
    else
      render status: :unauthorized
    end
  end
end
