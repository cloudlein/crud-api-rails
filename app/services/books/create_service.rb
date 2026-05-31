module Books
  class CreateService
    attr_reader :book

    def initialize(params)
      @params = params
      @book   = Book.new(@params)
    end

    def call
      @book.save!
      true
    end
  end
end