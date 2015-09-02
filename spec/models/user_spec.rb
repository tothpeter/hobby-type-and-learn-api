require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  it { should have_many :labels }
  it { should have_many :cards }

  it { should be_valid }

  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:auth_token_for_web)}

  describe "#generate_authentication_token!" do
    it "generates a token" do
      allow(Devise).to receive_messages(friendly_token: "auniquetoken123")

      @user.generate_authentication_token!
      expect(@user.auth_token_for_web).to eql "auniquetoken123"
    end
    
    it "generates another token when one already has been taken" do
      existing_user = FactoryGirl.create(:user, auth_token_for_web: "auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token_for_web).not_to eql existing_user.auth_token_for_web
    end
  end
end
