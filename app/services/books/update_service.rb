module Books
  class UpdateService
    attr_reader :book

    def initialize(id, params)
      @book   = Book.find(id)
      @params = params
    end

    def call
      @book.update!(@params)
      true
    end
  end
end