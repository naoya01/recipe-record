class Post < ApplicationRecord
  has_many :flavors, dependent: :destroy
  has_many :foodstuffs, dependent: :destroy
  has_many :recipes, dependent: :destroy
  accepts_nested_attributes_for :flavors,:foodstuffs,:recipes, allow_destroy: true
  attachment :post_image
end
