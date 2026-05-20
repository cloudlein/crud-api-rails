# frozen_string_literal: true

class BookUpdateService

  def self.call(dto)
    new(dto).call
  end

  def initialize(dto)
    @dto = dto
  end

end
