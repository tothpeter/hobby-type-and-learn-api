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

  describe "POST #create" do

    it "creates a single card" do
      user = FactoryGirl.create :user
      card_attributes = FactoryGirl.attributes_for :card
      temp_card = FactoryGirl.create :card, user: user
      
      api_authorization_header user.auth_token_for_web

      serializer = CardSerializer.new temp_card
      adapter = ActiveModel::Serializer::Adapter::JsonApi.new serializer
      temp_card.destroy!

      post :create, adapter.serializable_hash.merge({user_id: user.id})

      expect(json_response[:data][:attributes][:title]).to eql card_attributes[:title]
      should respond_with 201
    end

    it "creates a card with relationship to existing labels"

  end

end
