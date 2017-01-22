require 'test_helper'

class V1::MeasurementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @measurement = measurements(:one)
    @user = @measurement.user
    @access_token = @user.tokens.where(kind: 'access').first.uuid
  end

  test 'should index measurements' do
    get v1_measurements_url(access_token: @access_token), as: :json
    assert_response :success
  end

  test 'should show measurement' do
    get v1_measurement_url(@user, 'latest', access_token: @access_token), as: :json
    assert_response :success

    get v1_measurement_url(@user, @measurement, access_token: @access_token), as: :json
    assert_response :success
  end

  test 'should create measurement' do
    measurement_params = {
      age: @measurement.age,
      height: @measurement.height,
      weight: @measurement.weight,
      activity_level: @measurement.activity_level
    }

    assert_difference('@user.measurements.count') do
      post v1_measurements_url(access_token: @access_token), as: :json,
        params: measurement_params.merge(user_id: @user.id)
    end
    assert_response :created
  end

  test 'should update measurement' do
    patch v1_measurement_url(@measurement, access_token: @access_token),
      params: { age: 26 }, as: :json
    assert_response :success
    assert_equal 26, JSON.parse(response.body)['age']
  end

  test 'should destroy measurement' do
    Requirement.where(measurement: @measurement).destroy_all
    delete v1_measurement_url(@measurement, access_token: @access_token), as: :json
    assert_response :no_content
  end
end
