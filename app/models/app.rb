class App < ApplicationRecord
  include Level

  has_many :tokens, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :level, presence: true
  validates :redirect_uri, presence: true, uri: { query: false }

  before_create do
    self.client_id = UUIDTools::UUID.timestamp_create
    self.client_secret = UUIDTools::UUID.random_create
  end

  after_save do
    destroy_invalid_tokens if changed_attributes[:level]
  end

  private

  def destroy_invalid_tokens
    Token.where("level > #{App.levels[level]}", app: self).destroy_all
  end
end
