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

  [:tokens, :addresses, :measurements].each do |belongings|
    test "#{belongings} should be dstroy together" do
      assert_difference("#{belongings.to_s.singularize.capitalize}.count", -1) { @user.destroy }
    end
  end
end
