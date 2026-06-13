class Genre < ApplicationRecord

  has_many :book_genres, dependent: :destroy
  has_many :books, through: :book_genres

  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }
  validates :slug, presence: true, uniqueness: true,
                   format: { with: /\A[a-z0-9\-]+\z/, message: "only allows lowercase letters, numbers, and hyphens" }
end
