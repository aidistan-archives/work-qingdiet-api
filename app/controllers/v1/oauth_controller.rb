class V1::OauthController < ApplicationController
  before_action :app_http_basic_authenticate, only: :access_token

  def login
    render status: :forbidden
  end

  def authorize
    render status: :forbidden
  end

  def access_token
    case params[:grant_type]
    when 'password'
      user = User.find_by(username: params[:username])

      if user && user.authenticate(params[:password])
        token = Token.create(user: user, app: @current_app)
        return render json: {
          access_token: token.uuid,
          expires_in: token.expires_in
        }
      end

      render status: :unauthorized
    when 'code'
      render status: :forbidden
    else
      render status: :bad_request
    end
  end
end
