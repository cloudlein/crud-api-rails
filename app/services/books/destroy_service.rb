module Books
  class DestroyService
    attr_reader :book

    def initialize(id)
      @book = Book.find(id)
    end

    def call
      @book.destroy
      true
    end
  end
end
