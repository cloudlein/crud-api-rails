module Authors
  class CreateService
    attr_reader :author

    def initialize(params)
      @params = params
      @author = Author.new(@params)
    end

    def call
      @author.save!
      true
    end
  end
end
