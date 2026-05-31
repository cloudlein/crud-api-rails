class UsersController < ApplicationController
    include Paginatable
      before_action :require_admin, only: [:destroy]

    def index 
        collection = UserQuery.new(User.all, params).call
        @pagy, @users = paginate(collection)
    end

    def show
        @user = User.find(params[:id])
    end

    def create
        service = Users::CreateService.new(user_params)
        service.call
        @user = service.user
        render :create, status: :created
    end

    def update
        service = Users::UpdateService.new(params[:id], user_params)
        service.call
        @user = service.user
        render :update, status: :ok
    end

    def destroy
        Users::DestroyService.new(params[:id]).call
        head :no_content
    end

    private

    def user_params
        params.require(:user).permit(
            :name,
            :email,
            :password,
            :role
        )
    end
end