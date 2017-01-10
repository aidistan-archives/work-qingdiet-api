require 'test_helper'

class TokenTest < ActiveSupport::TestCase
  test 'fixtures should be valid' do
    Token.all.each do |token|
      assert token.valid?
    end
  end
end
