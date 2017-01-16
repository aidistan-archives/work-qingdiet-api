require 'test_helper'

class DishTest < ActiveSupport::TestCase
  def setup
    @dish = dishes(:one)
  end

  test_fixtures
  test_dependent_associations(exception: ComboItem)
end
