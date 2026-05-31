module Users
  class UpdateService
    attr_reader :user

    def initialize(id, params)
      @user   = User.find(id)
      @params = params
    end

    def call
      @user.update!(@params)
      true
    end
  end
end
