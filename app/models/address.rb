class Address < ApplicationRecord
  belongs_to :user

  validates :consignee, presence: true
  validates :province, presence: true
  validates :city, presence: true
  validates :detail, presence: true
  validates :mobile, presence: true, mobile: true
end
