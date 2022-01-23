class Tag < ApplicationRecord
  belongs_to :cooking
  belongs_to :genre
  validates :genre_id, presence: true
end
