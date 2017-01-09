require 'test_helper'

class V1::Login::OauthControllerTest < ActionDispatch::IntegrationTest
  setup do
    # NOTE: use :@_app instead of :@app to avoid a naming crashing.
    # See https://github.com/rails/rails/issues/26835 for more info.
    @_app = apps(:qingdiet)
    @user = users(:aidistan)
  end

  test 'should not authorize' do
    get v1_login_oauth_authorize_url, as: :json
    assert_response :forbidden
  end

  test 'should reject access_token without http authentication' do
    post v1_login_oauth_access_token_url, as: :json
    assert_response :unauthorized
  end

  test 'should reject access_token without grant_type' do
    post v1_login_oauth_access_token_url, headers: headers_with_credentials, as: :json
    assert_response :bad_request
  end

  test 'should support resource owner passwod credentials grant' do
    post v1_login_oauth_access_token_url,
      headers: headers_with_credentials,
      params: {
        grant_type: 'password',
        username: @user.username,
        password: 'Pa55word'
      },
      as: :json
    assert_response :success
  end

  private

  def headers_with_credentials
    {
      'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(
        @_app.client_id,
        @_app.client_secret
      )
    }
  end
end
