class Measurement < ApplicationRecord
  belongs_to :user
  has_many :requirements, dependent: :restrict_with_exception

  validates :age, numericality: { greater_than: 0 }
  validates :height, numericality: { greater_than: 0 }
  validates :weight, numericality: { greater_than: 0 }
  validates :activity_level, numericality: { greater_than: 0 }
end
