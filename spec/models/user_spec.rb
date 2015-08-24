require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  it { should be_valid }

  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:auth_token_for_web)}
end
