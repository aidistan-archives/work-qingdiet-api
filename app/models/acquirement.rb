class Acquirement < ApplicationRecord
  belongs_to :user
  belongs_to :combo
  belongs_to :requirement
end
