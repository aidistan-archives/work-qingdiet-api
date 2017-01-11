class V1::Login::OauthController < ApplicationController
  skip_before_action :authenticate_access_token
  before_action :authenticate_app_with_http_basic, only: :access_token

  def authorize
    if %w(code token).include?(params[:grant_type]) && (@app = App.find_by(client_id: params[:client_id]))
      if request.get?
        render layout: 'layouts/application'
      elsif create_token_with_credentials
        redirect_to @app.redirect_uri + '?' + redirect_query
      else
        @flash = 'Credentials failed'
        render layout: 'layouts/application'
      end
    else
      head :bad_request
    end
  end

  def access_token
    case params[:grant_type]
    when 'password'
      user = User.find_by(username: params[:username])

      if user && user.authenticate(params[:password])
        render json: user.tokens.create(app: @app).to_access_token
      else
        head :unauthorized
      end

    when 'authorization_code'
      token = Token.find_by(uuid: params[:code])

      # TODO: check whether expired
      if token && token.code_token? && token.app == @app
        render json: Token.create(app: @app, user: token.user).to_access_token
        token.destroy
      else
        head :unauthorized
      end

    else
      head :bad_request
    end
  end

  private

  def authenticate_app_with_http_basic
    @app = authenticate_with_http_basic do |id, secret|
      App.find_by(client_id: id, client_secret: secret)
    end

    request_http_basic_authentication unless @app
  end

  def create_token_with_credentials
    user = User.find_by(username: params[:credentials][:username])
    if user && user.authenticate(params[:credentials][:password])
      @token =
        if params[:grant_type] == 'code'
          user.tokens.create(app: @app, kind: 'code', expires_in: 10.minutes)
        else
          user.tokens.create(app: @app)
        end
    end
  end

  def redirect_query
    "state=#{params[:state]}&" +
      if params[:grant_type] == 'code'
        "code=#{@token.uuid}"
      else
        @token.to_access_token.map { |k, v| "#{k}=#{v}" }.join('&')
      end
  end
end
