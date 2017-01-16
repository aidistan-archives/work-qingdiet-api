require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def setup
    @order = orders(:one)
  end

  test_fixtures
  test_dependent_associations(destroy: Combo)
end
