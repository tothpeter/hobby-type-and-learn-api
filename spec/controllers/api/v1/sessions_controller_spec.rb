require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do

  describe "POST #create" do
    before(:each) do
      @user = FactoryGirl.create :user
    end

    context "When the credentials are correct" do
      before(:each) do
        credentials = { email: @user.email, password: "12345678" }
        post :create, { user: credentials }
      end

      it "returns the auth token" do
        @user.reload
        expect(json_response[:token]).to eql @user.auth_token_for_web
      end

      it { should respond_with 201 }
    end

    context "When the credentials are incorrect" do

      it "returns a json with an error" do
        credentials = { email: @user.email, password: "invalidpassword" }
        
        post :create, { user: credentials }

        expect(json_response[:errors]).to eql "Invalid email or password"
        should respond_with 401
      end

      it "returns a json with an error" do
        credentials = { email: "invalud_user@kalina.tech", password: "12345678" }
        
        post :create, { user: credentials }

        expect(json_response[:errors]).to eql "Invalid email or password"
        should respond_with 401
      end      
    end
  end
end
