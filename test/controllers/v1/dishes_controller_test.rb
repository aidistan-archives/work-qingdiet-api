require 'test_helper'

class V1::DishesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dish = dishes(:one)
    @user = users(:one)
    @access_token = @user.tokens.where(kind: 'access').first.uuid
  end

  test 'should index dishes' do
    get v1_dishes_url(access_token: @access_token), as: :json
    assert_response :success
  end

  test 'should show dish' do
    get v1_dish_url(@dish, access_token: @access_token), as: :json
    assert_response :success
  end

  test 'should create dish' do
    dish_params = {}

    assert_difference('Dish.count') do
      post v1_dishes_url(access_token: @access_token), as: :json,
        params: dish_params
    end
    assert_response :created
  end

  test 'should update dish' do
    patch v1_dish_url(@dish, access_token: @access_token),
      params: {}, as: :json
    assert_response :success
  end

  test 'should destroy dish' do
    ComboItem.where(dish: @dish).destroy_all
    delete v1_dish_url(@dish, access_token: @access_token), as: :json
    assert_response :no_content
  end
end
