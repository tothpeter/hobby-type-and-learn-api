require 'rails_helper'

RSpec.describe Api::V1::LabelCardsController, type: :controller do
  describe "POST #create" do

    it "creates the relationship between a label and a card" do
      user = FactoryGirl.create :user
      card = FactoryGirl.create :card, user: user
      label = FactoryGirl.create :label, user: user

      api_authorization_header user.auth_token_for_web

      post :create, {card_id: card.id, label_id: label.id}

      should respond_with 201
    end

  end
end