require 'test_helper'

class RootControllerTest < ActionDispatch::IntegrationTest
  test 'should get status' do
    get status_url
    assert_response :success
    get status_url, as: :json
    assert_response :success
  end
end
