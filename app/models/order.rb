class Order < ApplicationRecord
  belongs_to :user
  has_many :combos, dependent: :destroy

  enum status: { created: 0, packed: 1, locked: 2, payed: 3 }
end
