require 'test_helper'

class V1::RequirementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @requirement = requirements(:one)
    @user = @requirement.user
    @access_token = @user.tokens.where(kind: 'access').first.uuid
  end

  test 'should get index' do
    get v1_requirements_url(access_token: @access_token), as: :json
    assert_response :success
  end

  test 'should show requirement' do
    get v1_requirement_url(@requirement, access_token: @access_token), as: :json
    assert_response :success
  end

  test 'should create requirement' do
    requirement_params = {
      purpose: @requirement.purpose,
      measurement_id: measurements(:one).id
    }

    assert_difference('Requirement.count') do
      post v1_requirements_url(access_token: @access_token),
        params: requirement_params, as: :json
    end

    assert_response :created
  end

  test 'should update requirement' do
    patch v1_requirement_url(@requirement, access_token: @access_token),
      params: { purpose: 'smart' }, as: :json
    assert_response :ok
  end

  test 'should destroy requirement' do
    assert_difference('Requirement.count', -1) do
      delete v1_requirement_url(@requirement, access_token: @access_token), as: :json
    end

    assert_response :no_content
  end
end
