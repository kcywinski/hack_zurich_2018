class Drug < ApplicationRecord
  scope :low_amount, -> { where('tabs_number < 3') }
end
