require 'test_helper'

class V1::OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
    @user = @order.user
    @access_token = @user.tokens.where(kind: 'access').first.uuid
  end

  test 'should get index' do
    get v1_orders_url(access_token: @access_token), as: :json
    assert_response :success
  end

  test 'should create order' do
    order_params = { status: 'created' }

    assert_difference('Order.count') do
      post v1_orders_url(access_token: @access_token),
        params: order_params, as: :json
    end

    assert_response :created
  end

  test 'should show order' do
    get v1_order_url(@order, access_token: @access_token), as: :json
    assert_response :success
  end

  test 'should update order' do
    patch v1_order_url(@order, access_token: @access_token),
      params: { status: 'packed' }, as: :json
    assert_response :ok
  end

  test 'should destroy order' do
    assert_difference('Order.count', -1) do
      delete v1_order_url(@order, access_token: @access_token), as: :json
    end

    assert_response :no_content
  end
end
