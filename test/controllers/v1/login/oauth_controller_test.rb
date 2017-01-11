require 'test_helper'

class V1::Login::OauthControllerTest < ActionDispatch::IntegrationTest
  setup do
    # NOTE: use :@_app instead of :@app to avoid a naming crash.
    # See https://github.com/rails/rails/issues/26835 for more info.
    @_app = apps(:one)
    @user = users(:one)
  end

  test 'should reject authorize with wrong params' do
    get v1_login_oauth_authorize_url(grant_type: 'code'), as: :json
    assert_response :bad_request
    get v1_login_oauth_authorize_url(client_id: @_app.client_id), as: :json
    assert_response :bad_request
  end

  test 'should render authorize with right params' do
    get v1_login_oauth_authorize_url(grant_type: 'code', client_id: @_app.client_id)
    assert_response :success
  end

  test 'should reject access_token without http authentication' do
    post v1_login_oauth_access_token_url, as: :json
    assert_response :unauthorized
  end

  test 'should reject access_token without grant_type' do
    post v1_login_oauth_access_token_url, as: :json,
      headers: headers_with_credentials
    assert_response :bad_request
  end

  test 'should support authorization code grant' do
    post v1_login_oauth_authorize_url, params: {
      grant_type: 'code',
      client_id: @_app.client_id,
      credentials: { username: @user.username, password: 'Pa55word' }
    }
    assert_response :redirect
    assert_redirected_to Regexp.new(@_app.redirect_uri)
    assert code = CGI.parse(URI(response.headers['Location']).query)['code']

    post v1_login_oauth_access_token_url, as: :json,
      headers: headers_with_credentials,
      params: {
        grant_type: 'authorization_code',
        code: code
      }
    assert_response :success
    assert JSON.parse(response.body)['access_token']
  end

  test 'should support implicit grant' do
    post v1_login_oauth_authorize_url, params: {
      grant_type: 'token',
      client_id: @_app.client_id,
      credentials: { username: @user.username, password: 'Pa55word' }
    }
    assert_response :redirect
    assert_redirected_to Regexp.new(@_app.redirect_uri)
    assert CGI.parse(URI(response.headers['Location']).query)['access_token']
  end

  test 'should support resource owner passwod credentials grant' do
    post v1_login_oauth_access_token_url, as: :json,
      headers: headers_with_credentials,
      params: {
        grant_type: 'password',
        username: @user.username,
        password: 'Pa55word'
      }
    assert_response :success
    assert JSON.parse(response.body)['access_token']
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
