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

  test 'tokens should be destroy together' do
    token = @user.tokens.first
    @user.destroy
    assert_raises(ActiveRecord::RecordNotFound) { token.reload }
  end
end
