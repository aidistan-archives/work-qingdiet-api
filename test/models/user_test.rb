require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test_fixtures
  test_dependent_associations(
    destroy: [Token, Address, Order, Combo, Measurement, Requirement, Acquirement]
  )

  test 'username should be uniq' do
    user = @user.dup
    assert_not user.valid?
  end

  test 'level should be present' do
    @user.level = nil
    assert_not @user.valid?
  end

  test 'invalid tokens should be destroyed when level changed' do
    assert_difference('Token.where("level > 0", user: @user).count', -1) do
      @user.update_attribute(:level, 0)
    end
  end
end
