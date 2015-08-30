module Authenticable
  include ActionController::HttpAuthentication::Token::ControllerMethods
  
  # Devise methods overwrites
  def current_user
    authenticate_with_http_token do |token, options|
      @current_user ||= User.find_by(auth_token_for_web: token)
    end
  end

  def authenticate_with_token
    render json: { errors: "Not authenticated" }, status: :unauthorized unless user_signed_in?
  end

  def user_signed_in?
    current_user.present?
  end
  
end