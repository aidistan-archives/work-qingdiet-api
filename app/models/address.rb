class Address < ApplicationRecord
  belongs_to :user

  validates :consignee, presence: true
  validates :mobile, presence: true, mobile: true
  validates :province, presence: true
  validates :city, presence: true
  validates :district, presence: true
  validates :detail, presence: true

  before_create do
    self.last_used_at = Time.now
  end
end
