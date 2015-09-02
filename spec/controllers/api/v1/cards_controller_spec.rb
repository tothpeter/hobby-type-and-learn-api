require 'rails_helper'

RSpec.describe Api::V1::CardsController, type: :controller do

  describe "GET #index" do
    before :each do
      current_user = FactoryGirl.create :user
      api_authorization_header current_user.auth_token_for_web

      @label1 = FactoryGirl.create :label, user: current_user
      label2 = FactoryGirl.create :label, user: current_user

      card1 = FactoryGirl.create :card, user: current_user
      card2 = FactoryGirl.create :card, user: current_user

      FactoryGirl.create :label_card, card: card1, label: @label1
      FactoryGirl.create :label_card, card: card2, label: label2
    end

    it "returns all cards" do
      get :index

      expect(json_response[:data].length).to eq 2
      should respond_with 200
    end

    it "returns only the cards of label1" do
      get :index, {label_id: @label1.id}

      expect(json_response[:data].length).to eq 1
      should respond_with 200
    end
  end

end
