class Token < ApplicationRecord
  belongs_to :app
  belongs_to :user

  before_create do
    self.uuid = UUIDTools::UUID.timestamp_create
    self.expires_in = 2.weeks.to_i
    self.expired_at = 2.weeks.from_now
  end
end
