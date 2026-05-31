module Authors
  class UpdateService
    attr_reader :author

    def initialize(id, params)
      @author = Author.find(id)
      @params = params
    end

    def call
      @author.update!(@params)
      true
    end
  end
end