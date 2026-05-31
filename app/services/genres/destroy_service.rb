module Genres
  class DestroyService
    attr_reader :genre

    def initialize(id)
      @genre = Genre.find(id)
    end

    def call
      @genre.destroy
      true
    end
  end
end
