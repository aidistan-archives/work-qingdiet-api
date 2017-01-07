class User < ApplicationRecord
  has_many :tokens, dependent: :destroy
  has_secure_password

  validates :username, uniqueness: true
  validates :password, presence: true, allow_nil: true
end
