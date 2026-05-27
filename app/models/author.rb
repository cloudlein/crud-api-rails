# frozen_string_literal: true

class Author < ApplicationRecord

  has_many :books, dependent: :destroy

  validates :first_name, presence: true, length: { maximum: 100 }
  validates :last_name,  presence: true, length: { maximum: 100 }
  validates :pen_name,   length: { maximum: 100 }, allow_blank: true
  validates :bio,        length: { maximum: 1000 }, allow_blank: true

end
