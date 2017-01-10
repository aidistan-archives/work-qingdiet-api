class Measurement < ApplicationRecord
  belongs_to :user

  validates :age, numericality: { greater_than: 0 }
  validates :height, numericality: { greater_than: 0 }
  validates :weight, numericality: { greater_than: 0 }
  validates :activity_level, numericality: { greater_than: 0 }
end
