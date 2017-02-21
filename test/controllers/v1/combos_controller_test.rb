require 'test_helper'

class V1::CombosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @combo = combos(:one)
    @user = @combo.user
    @access_token = @user.tokens.where(kind: 'access').first.uuid
  end

  test 'should get index' do
    get v1_combos_url(access_token: @access_token), as: :json
    assert_response :success
  end

  test 'should create combo' do
    combo_params = {
      order_id: orders(:one).id,
      requirement_id: requirements(:two).id
    }

    assert_difference('Combo.count') do
      post v1_combos_url(access_token: @access_token),
        params: combo_params, as: :json
    end

    assert_response :created
  end

  test 'should show combo' do
    get v1_combo_url(@combo, access_token: @access_token), as: :json
    assert_response :success
  end

  test 'should destroy combo' do
    assert_difference('Combo.count', -1) do
      delete v1_combo_url(@combo, access_token: @access_token), as: :json
    end

    assert_response :no_content
  end
end
