require 'test_helper'

class RequirementTest < ActiveSupport::TestCase
  def setup
    @requirement = requirements(:one)
  end

  test_fixtures
  test_dependent_associations(destroy: [Combo, Acquirement])
end
