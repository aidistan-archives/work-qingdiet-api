require 'test_helper'

class V1::MeasurementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @measurement = measurements(:one)
    @user = @measurement.user
    @access_token = @user.tokens.first.uuid
  end

  test 'should get index' do
    get v1_user_measurements_url(@user, access_token: @access_token), as: :json
    assert_response :success
  end

  test 'should create measurement' do
    assert_difference('@user.measurements.count') do
      post v1_user_measurements_url(@user, access_token: @access_token), params: {
        measurement: {
          age: @measurement.age,
          height: @measurement.height,
          weight: @measurement.weight,
          activity_level: @measurement.activity_level
        }
      }, as: :json
    end

    assert_response 201
  end

  test 'should show measurement' do
    get v1_user_measurement_url(@user, @measurement, access_token: @access_token), as: :json
    assert_response :success
  end

  test 'should destroy measurement' do
    assert_difference('Measurement.count', -1) do
      delete v1_user_measurement_url(@user, @measurement, access_token: @access_token), as: :json
    end
    assert_response 204
  end
end
