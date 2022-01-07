class Recipe < ApplicationRecord
  belongs_to :post
    attachment :recipe_image
end
