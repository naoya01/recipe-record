class Cooking < ApplicationRecord
  belongs_to :meal
  has_many :tags
end
