class Token < ApplicationRecord
  belongs_to :app
  belongs_to :user

  enum kind: { access: 0, code: 1 }, _suffix: :token

  before_create do
    self.uuid = UUIDTools::UUID.timestamp_create
    self.kind ||= 'access'

    if expires_in.is_a?(ActiveSupport::Duration)
      self.expires_at = expires_in.from_now
      self.expires_in = expires_in.to_i
    else
      self.expires_in ||= 2.weeks.to_i
      self.expired_at ||= 2.weeks.from_now
    end
  end

  def mark_used(time: Time.now, ip: 'localhost')
    update_attributes(last_used_at: time, last_used_ip: ip)
  end

  def to_access_token
    { access_token: uuid, expires_in: expires_in, expired_at: expired_at } if access_token?
  end
end
