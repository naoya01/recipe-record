class Cooking < ApplicationRecord
  belongs_to :meal
  has_many :genres ,through: :tags
  
end
