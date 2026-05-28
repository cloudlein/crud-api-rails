class UsersController < ApplicationController
    include Paginatable

    def index 
        collection = UserQuery.new(User.all, params).call
        @pagy, @users = paginate(collection)
    end

    def show
        @user = User.find(params[:id])
    end

    def create
        @user = User.new(user_params)
        @user.save!
        render :create, status: :created
    end

    def update
        @user = User.find(params[:id])
        @user.update!(user_params)
        render :update, status: :ok
    end

    def destroy
        User.find(params[:id]).destroy
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