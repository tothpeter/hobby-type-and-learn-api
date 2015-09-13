require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  describe "GET #logged_in_user" do
    it "returns currently logged in user" do
      current_user = FactoryGirl.create :user
      api_authorization_header current_user.auth_token_for_web

      get :logged_in_user

      expect(json_response[:data][:id].to_i).to eq current_user.id
    end
  end

end
