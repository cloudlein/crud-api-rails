module Users
  class DestroyService
    attr_reader :user

    def initialize(id)
      @user = User.find(id)
    end

    def call
      @user.destroy
      true
    end
  end
end
