class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts
  has_many :meals
  has_many :genres

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
