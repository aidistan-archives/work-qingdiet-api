require 'test_helper'

class AppTest < ActiveSupport::TestCase
  setup do
    @app = apps(:one)
  end

  test_fixtures
  test_dependent_associations(destroy: Token)

  test 'name should be present' do
    @app.name = ' '
    assert_not @app.valid?
  end

  test 'name should not be too long' do
    @app.name = 'a' * 256
    assert_not @app.valid?
  end

  test 'level should be present' do
    @app.level = nil
    assert_not @app.valid?
  end

  test 'redirect_uri allowed to be nil' do
    @app.redirect_uri = nil
    assert @app.valid?
  end

  test 'redirect_uri should be present' do
    @app.redirect_uri = ' '
    assert_not @app.valid?
  end

  test 'redirect_uri should be valid' do
    @app.redirect_uri = '0://'
    assert_not @app.valid?
  end

  test 'redirect_uri should has no query' do
    @app.redirect_uri = 'http://www.example.com?query'
    assert_not @app.valid?
  end

  test 'invalid tokens should be destroyed when level changed' do
    assert_difference('Token.where("level > 0", app: @app).count', -1) do
      @app.update_attribute(:level, 0)
    end
  end
end
