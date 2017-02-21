require 'test_helper'

class ComboTest < ActiveSupport::TestCase
  def setup
    @combo = combos(:one)
  end

  test_fixtures
  test_dependent_associations(destroy: [ComboItem, Acquirement])

  test 'Parent requirement should have no other combos' do
    combo_params = {
      user: @combo.user,
      order: @combo.order,
      requirement: @combo.requirement
    }
    assert_raises(ActiveRecord::RecordNotUnique) { Combo.create(combo_params) }

    combo_params[:requirement] = Requirement.create(
      user: @combo.user,
      measurement: @combo.requirement.measurement
    )
    assert_nothing_raised { Combo.create(combo_params) }
  end
end
