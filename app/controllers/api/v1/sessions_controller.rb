class Api::V1::SessionsController < ApplicationController
  def create
    user_password = params[:user][:password]
    user_email = params[:user][:email]
    
    user = user_email.present? && User.find_by(email: user_email)

    if user.present? && user.valid_password?(user_password)
      user.generate_authentication_token!
      user.save

      data = {
        token: user.auth_token_for_web,
        email: user.email,
      }
      
      render json: data, status: 201
    else
      render json: { errors: "Invalid email or password" }, status: 401
    end
  end
end
