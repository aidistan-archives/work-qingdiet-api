class User < ApplicationRecord
  include Level

  has_many :tokens
  has_many :orders
  has_many :combos
  has_many :addresses
  has_many :measurements
  has_many :requirements
  has_many :acquirements

  enum gender: { unknown_gender: 0, male: 1, female: 2 }
  has_secure_password

  validates :username, uniqueness: true, allow_nil: true
  validates :weixin_id, uniqueness: true, allow_nil: true
  validates :password, presence: true, allow_nil: true
  validates :level, presence: true

  # Must have one identifer at least
  validate do
    # Only add to :username for error display
    errors.add :username, :blank if username.nil? && weixin_id.nil?
  end

  after_save do
    destroy_invalid_tokens if changed_attributes[:level]
  end

  # To prevent ActiveRecord::DeleteRestrictionError, we have to destroy
  # the dependencies ourselves
  before_destroy do
    tokens.destroy_all
    addresses.destroy_all

    orders.destroy_all
    requirements.destroy_all
    measurements.destroy_all
  end

  private

  def destroy_invalid_tokens
    Token.where("level > #{User.levels[level]}", user: self).destroy_all
  end
end
