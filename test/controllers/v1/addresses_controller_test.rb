require 'test_helper'

class V1::AddressesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @address = addresses(:one)
    @user = @address.user
    @access_token = @user.tokens.where(kind: 'access').first.uuid
  end

  test 'should index addresses' do
    get v1_addresses_url(access_token: @access_token), as: :json
    assert_response :success
  end

  test 'should show address' do
    get v1_address_url(@address, access_token: @access_token), as: :json
    assert_response :success
  end

  test 'should create address' do
    address_params = {
      consignee: @address.consignee,
      mobile: @address.mobile,
      province: @address.province,
      city: @address.city,
      district: @address.district,
      detail: @address.detail
    }

    assert_difference('@user.addresses.count') do
      post v1_addresses_url(access_token: @access_token), as: :json,
        params: address_params.merge(user_id: @user.id)
    end
    assert_response :created
  end

  test 'should update address' do
    patch v1_address_url(@address, access_token: @access_token),
      params: { name: 'name' }, as: :json
    assert_response :success
    assert_equal 'name', JSON.parse(response.body)['name']
  end

  test 'should destroy address' do
    Order.where(address: @address).destroy_all
    delete v1_address_url(@address, access_token: @access_token), as: :json
    assert_response :no_content
  end
end
