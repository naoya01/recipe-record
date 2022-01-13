class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts, dependent: :destroy
  has_many :meals, dependent: :destroy
  has_many :genres, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :cookings, through: :favorites
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
