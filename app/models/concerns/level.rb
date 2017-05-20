# Actions in QingDiet are authorized based on the level, an enum attribute, of
# the token included in the request. The mechanism is simple but well enough for
# a system like QingDiet for now.
#
# - [0, 4]: users, external and 3rd-party apps
# - [5, 9]: staffs and internal apps
# - [-9, -1]: irregular users
#
module Level
  extend ActiveSupport::Concern

  included do
    enum level: {
      standard: 0,
      staff: 5,
      super: 9
    }, _suffix: true
  end
end
