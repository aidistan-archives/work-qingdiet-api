class User < ApplicationRecord
  has_secure_password
  has_many :tokens, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :combos, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :measurements, dependent: :destroy
  has_many :requirements, dependent: :destroy
  has_many :acquirements, dependent: :destroy

  validates :username, uniqueness: true
  validates :password, presence: true, allow_nil: true
end
