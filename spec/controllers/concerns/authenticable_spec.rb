require 'rails_helper'

class Authentication
  include Authenticable

  def request;end
  def response;end
  def render args
  end
end

describe Authenticable do
  let(:authentication) { Authentication.new } 
  subject { authentication }

  describe "#current_user" do
    before do
      @user = FactoryGirl.create :user
      request.headers["Authorization"] = "Token token=\"#{@user.auth_token_for_web}\""
      allow(authentication).to receive_messages(:request => request)
    end

    it "returns the user from the authorization header" do
      expect(authentication.current_user.auth_token_for_web).to eql @user.auth_token_for_web
    end
  end

  describe "#authenticate_with_token" do
    before do
      allow(authentication).to receive(:current_user).and_return(nil)
      allow(authentication).to receive(:render) do |args|
        args
      end
    end

    it "returns error" do
      expect(authentication.authenticate_with_token[:json][:errors]).to eql "Not authenticated"
    end

    it "returns unauthorized status" do
      expect(authentication.authenticate_with_token[:status]).to eql :unauthorized
    end
  end

  describe "#user_signed_in?" do
    context "when there is a user on 'session'" do
      before do
        @user = FactoryGirl.create :user
        allow(authentication).to receive(:current_user).and_return(@user)
      end

      it { should be_user_signed_in }
    end

    context "when there is no user on 'session'" do
      before do
        @user = FactoryGirl.create :user
        allow(authentication).to receive(:current_user).and_return(nil)
      end

      it { should_not be_user_signed_in }
    end
  end
end