class V1::Login::OauthController < ApplicationController
  skip_before_action :authenticate_access_token
  before_action :authenticate_app_with_http_basic, only: :access_token

  def authorize
    render body: nil, status: :forbidden
  end

  def access_token
    case params[:grant_type]
    when 'password'
      user = User.find_by(username: params[:username])

      unless user && user.authenticate(params[:password])
        return render body: nil, status: :unauthorized
      end

      @token = Token.create(user: user, app: @current_app)
    when 'code'
      render body: nil, status: :forbidden
    else
      render body: nil, status: :bad_request
    end
  end

  private

  def authenticate_app_with_http_basic
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
