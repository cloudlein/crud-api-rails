module Genres
  class UpdateService
    attr_reader :genre

    def initialize(id, params)
      @genre  = Genre.find(id)
      @params = params
    end

    def call
      @genre.update!(@params)
      true
    end
  end
end
