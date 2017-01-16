class Dish < ApplicationRecord
  has_many :combo_items, dependent: :restrict_with_exception
end
