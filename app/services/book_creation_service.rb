# frozen_string_literal: true

class BookCreationService
  def self.call(dto)
    new(dto).call
  end

  def initialize(dto)
    @dto = dto
  end

  def call
    Book.create!(title: @dto.title, author_id: @dto.author_id)
  end
end
