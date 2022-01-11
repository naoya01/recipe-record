class Meal < ApplicationRecord
  belongs_to :user
  has_many :cookings, dependent: :destroy
  accepts_nested_attributes_for :cookings, allow_destroy: true

end
