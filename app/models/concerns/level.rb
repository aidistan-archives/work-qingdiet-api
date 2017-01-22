# Actions in QingDiet are authorized based on the level, an enum attribute, of
# the token included in the request. The mechanism is simple but well enough for
# a system like QingDiet for now.
#
# - 0 ~ 4 are for the users, from standard ones to premium ones
# - 5 ~ 9 are for the staffs, from cooks to supers
# - -9 ~ -1 are for the irregular users, from canceled ones to inactivated ones
#
module Level
  extend ActiveSupport::Concern

  included do
    enum level: { standard: 0, super: 9 }, _suffix: :level
  end
end
