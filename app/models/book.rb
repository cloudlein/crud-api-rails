class Book < ApplicationRecord

  belongs_to :author

  has_many :book_genres, dependent: :destroy
  has_many :genres, through: :book_genres

  validates :title,     presence: true, length: { minimum: 1, maximum: 255 }
  validates :author_id, presence: true

end
