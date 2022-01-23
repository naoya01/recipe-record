class Flavor < ApplicationRecord
  belongs_to :post
  validates :flavor_name, presence: true
  validates :flavor_quantity, presence: true
end