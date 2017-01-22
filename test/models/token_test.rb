require 'test_helper'

class TokenTest < ActiveSupport::TestCase
  def setup
    @token = tokens(:one)
  end

  test_fixtures

  test 'should check user level and app level' do
    assert_not Token.new(
      level: 'super',
      app: App.find_by(level: 'super'),
      user: User.find_by(level: 'standard')
    ).valid?

    assert_not Token.new(
      level: 'super',
      app: App.find_by(level: 'standard'),
      user: User.find_by(level: 'standard')
    ).valid?
  end
end
