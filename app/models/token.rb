class Token < ApplicationRecord
  belongs_to :app
  belongs_to :user

  enum kind: { access: 0, code: 1 }, _suffix: :token

  before_create do
    self.uuid = UUIDTools::UUID.timestamp_create
    self.kind ||= 'access'
    self.expires_in ||= 2.weeks.to_i
    self.expires_at ||= Time.now + expires_in
  end

  def expired?(destroy_on_expiration: true)
    (expires_at && expires_at < Time.now).tap do |expired|
      destroy if expired && destroy_on_expiration
    end
  end

  def to_access_token
    { access_token: uuid, expires_in: expires_in, expires_at: expires_at } if access_token?
  end
end
