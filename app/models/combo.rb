class Combo < ApplicationRecord
  belongs_to :user
  belongs_to :order
  belongs_to :requirement
  has_one :acquirement, dependent: :destroy
  has_many :combo_items, dependent: :destroy
end
