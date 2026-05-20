# frozen_string_literal: true

class BookCreationDTO
  include ActiveModel::Validations
  include ActiveModel::Model

  attr_accessor :title, :author_id, :genre_ids

  validates :title,  presence: true
  validates :author_id, numericality: { only_integer: true }

end
