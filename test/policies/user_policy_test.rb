require 'test_helper'

class UserPolicyTest < ActiveSupport::TestCase
  setup do
    setup_context
  end

  test 'should index users for super user' do
    assert Pundit.policy_scope(@context, User).size > 1
  end

  test 'should not index users for standard user' do
    assert_raises(Pundit::NotAuthorizedError) do
      Pundit.policy_scope(@other_context, User)
    end
  end

  test 'should show any user for super user' do
    assert Pundit.policy(@context, @user).show?
  end

  test 'should show own user for standard user' do
    assert_not Pundit.policy(@other_context, @user).show?
  end

  test 'should update any user for super user' do
    assert Pundit.policy(@context, @user).update?
  end

  test 'should update own user for standard user' do
    assert_not Pundit.policy(@other_context, @user).update?
  end
end
