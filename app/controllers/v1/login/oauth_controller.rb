class V1::Login::OauthController < V1::LoginController
  before_action :authenticate_app_with_http_basic, only: :access_token

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
