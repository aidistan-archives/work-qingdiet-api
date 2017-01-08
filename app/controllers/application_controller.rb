class ApplicationController < ActionController::API
  # API application have to include it explicitly
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  before_action :token_http_authenticate

  def app_http_basic_authenticate
    app = authenticate_with_http_basic do |id, secret|
      App.find_by(client_id: id, client_secret: secret)
    end

    if app
      @current_app = app
    else
      request_http_basic_authentication
    end
  end

  def token_http_authenticate
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
