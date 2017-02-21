require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  setup do
    @address = addresses(:one)
  end

  test_fixtures

  test 'consignee should be present' do
    @address.consignee = ' '
    assert_not @address.valid?
  end

  test 'province should be present' do
    @address.province = ' '
    assert_not @address.valid?
  end

  test 'city should be present' do
    @address.city = ' '
    assert_not @address.valid?
  end

  test 'district should be present' do
    @address.district = ' '
    assert_not @address.valid?
  end

  test 'detail should be present' do
    @address.detail = ' '
    assert_not @address.valid?
  end

  test 'mobile should be present and valid' do
    @address.mobile = ' '
    assert_not @address.valid?
    @address.mobile = '010-88688888'
    assert_not @address.valid?
  end
end
