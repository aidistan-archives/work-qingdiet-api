require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test 'fixtures should be valid' do
    User.all.each do |user|
      assert user.valid?
    end
  end

  test 'username should be uniq' do
    user = @user.dup
    assert_not user.valid?
  end

  { tokens: -2, addresses: -1, measurements: -1 }.each do |belongings, change|
    test "#{belongings} should be dstroy together" do
      belonging_model_name = belongings.to_s.singularize.capitalize
      assert_difference("#{belonging_model_name}.count", change) { @user.destroy }
    end
  end
end
