class App < ApplicationRecord
  has_many :tokens, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :redirect_uri, presence: true, uri: true

  before_create do
    self.client_id = UUIDTools::UUID.timestamp_create
    self.client_secret = UUIDTools::UUID.random_create
  end
end
