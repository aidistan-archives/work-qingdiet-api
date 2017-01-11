require 'test_helper'

class V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @access_token = @user.tokens.where(kind: 'access').first.uuid
  end

  test 'should reject request without access_token' do
    get v1_user_url(@user), as: :json
    assert_response :unauthorized
  end

  test 'should reject request with expired access_token' do
    Token.find_by(uuid: @access_token).update_attribute(:expires_at, Time.now - 1)

    assert_difference('Token.count', -1) do
      get v1_user_url(@user, access_token: @access_token), as: :json
    end
    assert_response :unauthorized
  end

  test 'should check authorization' do
    other_access_token = users(:two).tokens.where(kind: 'access').first.uuid
    skip('We shall check authorization later')
    get v1_user_url(@user, access_token: other_access_token), as: :json
    assert_response :unauthorized
    patch v1_user_url(@user, access_token: other_access_token), as: :json
    assert_response :unauthorized
    delete v1_user_url(@user, access_token: other_access_token), as: :json
    assert_response :unauthorized
  end

  test 'should show user' do
    get v1_user_url('me', access_token: @access_token), as: :json
    assert_response :success
    get v1_user_url(@user, access_token: @access_token), as: :json
    assert_response :success
  end

  test 'should update user' do
    patch v1_user_url(@user, access_token: @access_token), as: :json
    assert_response 200
  end

  test 'should destroy user' do
    assert_difference('User.count', -1) do
      delete v1_user_url(@user, access_token: @access_token), as: :json
    end
    assert_response 204
  end
end
