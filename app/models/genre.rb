class Genre < ApplicationRecord
  has_many :tags
  has_many :cookings,through: :tags
  has_many :meals, through: :cookings
  belongs_to :user
  validates :genre_name, uniqueness: true, presence: true

end
