class V1::Login::WeixinController < ApplicationController
  skip_before_action :authenticate_access_token

  def access_token
    uri = URI('https://api.weixin.qq.com/sns/jscode2session')
    uri.query = URI.encode_www_form(
      appid: ENV['WXAPP_APPID'],
      secret: ENV['WXAPP_SECRET'],
      js_code: params[:code],
      grant_type: 'authorization_code'
    )

    res = JSON.parse(Net::HTTP.get(uri))
    if res['errcode']
      head :unauthorized
    else
      user = User.find_by(weixin_id: res['openid'])
      user = User.create(weixin_id: res['openid'], password: res['openid']) unless user
      render json: user.tokens.create(app: App[:weixin], expires_in: res['expire_in'], level: 'standard').to_access_token
    end
  end
end
