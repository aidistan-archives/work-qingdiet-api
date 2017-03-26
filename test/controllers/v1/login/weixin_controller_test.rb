require 'test_helper'

class V1::Login::WeixinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    stub_request(:get, 'https://api.weixin.qq.com/sns/jscode2session')
      .with(query: hash_including(js_code: 'mock'))
      .to_return(body: { session_key: 'SESSIONKEY', expire_in: 7200, openid: 'OPENID' }.to_json)
    WebMock.allow_net_connect!
  end

  test 'should fail with fake weixin code' do
    post v1_login_weixin_access_token_url, as: :json,
      params: { code: 'fake' }
    assert_response :unauthorized
  end

  test 'should succeed with real weixin code' do
    post v1_login_weixin_access_token_url, as: :json,
      params: { code: 'mock' }
    assert_response :success
    assert JSON.parse(response.body)['access_token']
  end

  teardown do
    WebMock.disable_net_connect!
  end
end
