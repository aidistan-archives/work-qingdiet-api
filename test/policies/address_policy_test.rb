require 'test_helper'

class AddressPolicyTest < ActiveSupport::TestCase
  setup do
    setup_context
    @address = addresses(:one)
    @other_address = addresses(:two)
  end

  test 'should index all addresses for super user' do
    addresses = Pundit.policy_scope(@context, Address)
    assert addresses.map(&:user).uniq.size > 1
  end

  test 'should index own addresses for standard user' do
    addresses = Pundit.policy_scope(@other_context, Address)
    assert addresses.map(&:user).uniq.first == @other_user
  end

  test 'should show any address for super user' do
    assert Pundit.policy(@context, @address).show?
    assert Pundit.policy(@context, @other_address).show?
  end

  test 'should show own address for standard user' do
    assert_not Pundit.policy(@other_context, @address).show?
    assert Pundit.policy(@other_context, @other_address).show?
  end

  test 'should create any address for super user' do
    assert Pundit.policy(@context, @address).create?
    assert Pundit.policy(@context, @other_address).create?
  end

  test 'should create own address for standard user' do
    assert_not Pundit.policy(@other_context, @address).create?
    assert Pundit.policy(@other_context, @other_address).create?
  end

  test 'should update any address for super user' do
    assert Pundit.policy(@context, @address).update?
    assert Pundit.policy(@context, @other_address).update?
  end

  test 'should update own address for standard user' do
    assert_not Pundit.policy(@other_context, @address).update?
    assert Pundit.policy(@other_context, @other_address).update?
  end

  test 'should destroy any address for super user' do
    assert Pundit.policy(@context, @address).destroy?
    assert Pundit.policy(@context, @other_address).destroy?
  end

  test 'should destroy own address for standard user' do
    assert_not Pundit.policy(@other_context, @address).destroy?
    assert Pundit.policy(@other_context, @other_address).destroy?
  end
end
