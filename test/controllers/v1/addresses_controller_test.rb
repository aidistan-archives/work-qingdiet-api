require 'test_helper'

class V1::AddressesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @address = addresses(:one)
    @user = @address.user
    @access_token = @user.tokens.first.uuid
  end

  test 'should get index' do
    get v1_user_addresses_url(@user, access_token: @access_token), as: :json
    assert_response :success
  end

  test 'should create address' do
    assert_difference('@user.addresses.count') do
      post v1_user_addresses_url(@user, access_token: @access_token), params: {
        consignee: @address.consignee,
        mobile: @address.mobile,
        province: @address.province,
        city: @address.city,
        district: @address.district,
        detail: @address.detail
      }, as: :json
    end
    assert_response 201
  end

  test 'should show address' do
    get v1_user_address_url(@user, @address, access_token: @access_token), as: :json
    assert_response :success
  end

  test 'should update address' do
    patch v1_user_address_url(@user, @address, access_token: @access_token),
      params: { name: 'name' }, as: :json
    assert_response 200
    assert_equal 'name', JSON.parse(response.body)['name']
  end

  test 'should destroy address' do
    assert_difference('@user.addresses.count', -1) do
      delete v1_user_address_url(@user, @address, access_token: @access_token), as: :json
    end
    assert_response 204
  end
end
