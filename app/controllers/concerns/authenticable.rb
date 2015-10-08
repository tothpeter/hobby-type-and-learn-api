module Authenticable
  include ActionController::HttpAuthentication::Token::ControllerMethods
  
  # Devise methods overwrites
  def current_user
    authenticate_with_http_token do |token, options|
      @current_user ||= User.where('auth_token_for_web=? or auth_token_for_chrome=?', token, token).first
    end
  end

  def authenticate_with_token
    render json: { errors: {title: "Not authenticated", status: 401} }, status: :unauthorized unless user_signed_in?
  end

  def user_signed_in?
    current_user.present?
  end
  
end