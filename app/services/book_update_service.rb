# frozen_string_literal: true

class BookUpdateService

  def self.call(dto)
    new(dto).call
  end

  def initialize(dto)
    @dto = dto
  end

  def call
    book = Book.find(@dto.id)
    book.update!(
      title: @dto.title,
      author_id: @dto.author_id,
      genre_ids: @dto.genre_ids || []
    )
    book
  end
end
