require 'test_helper'

class AppTest < ActiveSupport::TestCase
  setup do
    @app = apps(:test)
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

  test 'redirect_uri should be a valid uri' do
    @app.redirect_uri = '0://'
    assert_not @app.valid?
  end
end
