require 'test_helper'

class AppTest < ActiveSupport::TestCase
  setup do
    @app = apps(:one)
  end

  test 'fixtures should be valid' do
    App.all.each do |app|
      assert app.valid?
    end
  end

  test 'name should be present' do
    @app.name = ' '
    assert_not @app.valid?
  end

  test 'name should not be too long' do
    @app.name = 'a' * 256
    assert_not @app.valid?
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

  test 'tokens should be destroy together' do
    assert_difference('Token.count', -3) { @app.destroy }
  end
end
