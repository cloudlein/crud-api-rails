module Authors
  class DestroyService
    attr_reader :author

    def initialize(id)
      @author = Author.find(id)
    end

    def call
      @author.destroy
      true
    end
  end
end