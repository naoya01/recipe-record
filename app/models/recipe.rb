class Recipe < ApplicationRecord
  belongs_to :post
    attachment :recipe_image
    validates :recipe_description, presence: true
end
