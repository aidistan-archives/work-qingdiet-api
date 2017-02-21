class Requirement < ApplicationRecord
  belongs_to :user
  belongs_to :measurement
  has_one :combo, dependent: :destroy
  has_one :acquirement, dependent: :destroy

  enum purpose: { god: 0, smart: 1, balance: 2, fat_burning: 3, muscle_buiding: 4 }

  validates :purpose, presence: true

  def initialize(attributes = nil)
    super(attributes)

    # Set the same user_id as measurement
    self.user = measurement.user if measurement

    # NOTE: complicated calculations of the nutritions will be placed here
  end
end
