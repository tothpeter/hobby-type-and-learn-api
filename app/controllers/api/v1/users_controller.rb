class Api::V1::UsersController < ApplicationController
  def logged_in_user
    render json: current_user, include: ['labels']
  end
end
