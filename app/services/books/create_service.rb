module Books
  class CreateService
    attr_reader :book

    def initialize(params)
      @params = params
      @book   = Book.new(@params)
    end

    def call
      if @book.save
        NotifyNewBookJob.perform_later(@book.id)
        true
      else
        false
      end
    end
  end
end