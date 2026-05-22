class Genre < ApplicationRecord

  has_many :book_genres
  has_many :books, through: :book_genres

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :slug, presence: true, uniqueness: true
end
