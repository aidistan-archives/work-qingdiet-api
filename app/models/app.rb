class App < ApplicationRecord
  include Level

  has_many :tokens, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :level, presence: true
  validates :redirect_uri, presence: true, uri: { query: false }, allow_nil: true

  before_create do
    self.client_id = UUIDTools::UUID.timestamp_create
    self.client_secret = UUIDTools::UUID.random_create
  end

  after_save do
    destroy_invalid_tokens if changed_attributes[:level]
  end

  # Fetch preset app by symbol
  def self.[](sym)
    params =
      case sym
      when :weixin then { name: 'weixin', level: 'standard' }
      else return nil
      end
    App.find_by(params) || App.create(params)
  end

  private

  def destroy_invalid_tokens
    Token.where("level > #{App.levels[level]}", app: self).destroy_all
  end
end
