class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: [:register, :login]

  def register
    user = User.new(user_params)
    if user.save
      token = JsonWebToken.encode(user_id: user.id)
      render json: {
         token: token, 
         user: user.as_json(except: :password_digest)
        }, status: :created
    else 
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private 

  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :role)
  end
end