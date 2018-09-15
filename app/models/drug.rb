class Drug < ApplicationRecord
  scope :low_amount, -> { where('amount_left < 5') }
end
