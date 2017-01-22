class User < ApplicationRecord
  include Level

  has_many :tokens, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :combos, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :measurements, dependent: :destroy
  has_many :requirements, dependent: :destroy
  has_many :acquirements, dependent: :destroy

  has_secure_password

  validates :username, uniqueness: true
  validates :password, presence: true, allow_nil: true
  validates :level, presence: true

  after_save do
    destroy_invalid_tokens if changed_attributes[:level]
  end

  private

  def destroy_invalid_tokens
    Token.where("level > #{User.levels[level]}", user: self).destroy_all
  end
end
