class Cooking < ApplicationRecord
  belongs_to :meal
  has_many :tags, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :genres ,through: :tags
  accepts_nested_attributes_for :tags, allow_destroy: true
  accepts_nested_attributes_for :genres, allow_destroy: true
  accepts_nested_attributes_for :meal, allow_destroy: true

  VALID_URL_REGEX = /https?:\/\/[\w\/:%#\$&\?\(\)~\.=\+\-]+|\A\z/
  validates :url,
  format: { with: VALID_URL_REGEX, message: '正しいURLを入力してください' }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end

