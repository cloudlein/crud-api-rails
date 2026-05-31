module Genres
  class CreateService
    attr_reader :genre

    def initialize(params)
      @params = params
      @genre  = Genre.new(@params)
    end

    def call
      @genre.save!
      true
    end
  end
end
