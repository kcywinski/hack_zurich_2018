class Drug < ApplicationRecord
  scope :low_amount, -> { where('packs_amount < 3') }
end
