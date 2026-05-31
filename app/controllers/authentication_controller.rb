class AuthenticationController < ApplicationController
  skip_before_action :authenticate_user, only: [:register, :login]

  def register
    user = User.new(register_params)
    user.save!

    token = JsonWebToken.encode({ user_id: user.id })
    render json: {
      token: token,
      user: user.as_json(except: :password_digest)
    }, status: :created
  end


  def login
    user = User.find_by(email: login_params[:email])

    if user&.authenticate(login_params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token: token, user: user.as_json(except: :password_digest) }
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  private 

  def login_params
    params.permit(:email, :password, :password_confirmation)
  end

  def register_params
    params.permit(:name, :email, :password, :password_confirmation, :role)
  end

end