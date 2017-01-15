class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :combos, dependent: :destroy
end
