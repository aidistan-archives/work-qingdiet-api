require 'test_helper'

class ComboTest < ActiveSupport::TestCase
  def setup
    @combo = combos(:one)
  end

  test_fixtures
  test_dependent_associations(destroy: [ComboItem, Acquirement])

  test 'Parent requirement should be destroyed together' do
    assert Requirement.find(@combo.requirement.id)

    @combo.destroy

    assert_raises(ActiveRecord::RecordNotFound) do
      Requirement.find(@combo.requirement.id)
    end
  end
end
