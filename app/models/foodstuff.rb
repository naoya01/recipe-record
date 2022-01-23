class Foodstuff < ApplicationRecord
  belongs_to :post
  validates :foodstuff_name, presence: true
  validates :foodstuff_quantity, presence: true
end
