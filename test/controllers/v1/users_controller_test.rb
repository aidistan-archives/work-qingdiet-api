require 'test_helper'

class V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @access_token = @user.tokens.first.uuid
  end

  test 'should check access_token' do
    get v1_user_url(@user), as: :json
    assert_response :unauthorized
  end

  test 'should show me' do
    get v1_user_url('me', access_token: @access_token), as: :json
    assert_response :success
  end

  test 'should show user' do
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
