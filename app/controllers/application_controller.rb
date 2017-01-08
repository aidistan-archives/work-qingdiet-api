class ApplicationController < ActionController::API
  # API application have to include it explicitly
  include ActionController::HttpAuthentication::Basic::ControllerMethods

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
end
