class Meal < ApplicationRecord
  belongs_to :user
  has_many :cookings, dependent: :destroy
  has_many :tags, through: :cookings
  has_many :genres, through: :tags
  accepts_nested_attributes_for :cookings, allow_destroy: true
end
