class Genre < ApplicationRecord
  has_many :tags
  belongs_to :user
  validates :genre_name, uniqueness: true
end
