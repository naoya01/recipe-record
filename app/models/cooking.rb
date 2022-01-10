class Cooking < ApplicationRecord
  belongs_to :meal
  has_many :tags
  has_many :genres ,through: :tags
  accepts_nested_attributes_for :tags, allow_destroy: true
  accepts_nested_attributes_for :genres, allow_destroy: true
end

