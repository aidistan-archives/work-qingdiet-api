class User < ApplicationRecord
  has_secure_password
  has_many :tokens, dependent: :destroy
  has_many :measurements, dependent: :destroy

  validates :username, uniqueness: true
  validates :password, presence: true, allow_nil: true
end
