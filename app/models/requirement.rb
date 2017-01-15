class Requirement < ApplicationRecord
  belongs_to :user
  belongs_to :measurement
  has_one :combo, dependent: :destroy
  has_one :acquirement, dependent: :destroy
end
