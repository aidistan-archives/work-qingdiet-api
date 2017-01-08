require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:aidistan)
  end

  test 'should show user' do
    get v1_user_url(@user), as: :json
    assert_response :success
  end

  test 'should update user' do
    patch v1_user_url(@user), params: { user: {} }, as: :json
    assert_response 200
  end

  test 'should destroy user' do
    assert_difference('User.count', -1) do
      delete v1_user_url(@user), as: :json
    end

    assert_response 204
  end
end
