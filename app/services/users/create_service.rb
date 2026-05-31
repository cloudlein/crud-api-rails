module Users
  class CreateService
    attr_reader :user

    def initialize(params)
      @params = params
      @user   = User.new(@params)
    end

    def call
      @user.save!
      true
    end
  end
end
