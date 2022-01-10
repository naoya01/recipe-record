class Genre < ApplicationRecord
  has_many :cookings,through: :tags
  belongs_to :user
  validates :genre_name, uniqueness: true
end
