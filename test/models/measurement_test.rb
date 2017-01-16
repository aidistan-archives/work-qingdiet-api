require 'test_helper'

class MeasurementTest < ActiveSupport::TestCase
  setup do
    @measurement = measurements(:one)
  end

  test_fixtures
  test_dependent_associations(exception: Requirement)

  test 'age should be greater than 0' do
    @measurement.age = 0
    assert_not @measurement.valid?
  end

  test 'height should be greater than 0' do
    @measurement.height = 0
    assert_not @measurement.valid?
  end

  test 'weight should be greater than 0' do
    @measurement.weight = 0
    assert_not @measurement.valid?
  end

  test 'activity_level should be greater than 0' do
    @measurement.activity_level = 0
    assert_not @measurement.valid?
  end
end
