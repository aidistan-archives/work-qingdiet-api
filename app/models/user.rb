class User < ApplicationRecord
  has_many :tokens, dependent: :destroy
  has_secure_password
end
