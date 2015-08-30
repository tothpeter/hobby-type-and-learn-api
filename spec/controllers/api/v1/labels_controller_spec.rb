require 'rails_helper'

RSpec.describe Api::V1::LabelsController, type: :controller do
  describe "POST #create" do

    context "when is successfully created" do
      it "renders the json representation for the label record just created" do
        user = FactoryGirl.create :user
        temp_label = FactoryGirl.create :label, user: user
        label_attributes = FactoryGirl.attributes_for :label
        
        api_authorization_header user.auth_token_for_web

        serializer = LabelSerializer.new temp_label
        adapter = ActiveModel::Serializer::Adapter::JsonApi.new serializer
        temp_label.destroy!

        post :create, adapter.serializable_hash.merge({user_id: user.id})

        expect(json_response[:data][:attributes][:title]).to eql label_attributes[:title]
        should respond_with 201
      end
    end

    context "when is not created" do
      it "renders an errors json" do
        user = FactoryGirl.create :user
        temp_label = FactoryGirl.create :label, user: user
        
        api_authorization_header user.auth_token_for_web

        serializer = LabelSerializer.new temp_label
        adapter = ActiveModel::Serializer::Adapter::JsonApi.new serializer
        temp_label.destroy!

        invalid_label_attributes = adapter.serializable_hash
        invalid_label_attributes[:data][:attributes][:title] = ""

        post :create, invalid_label_attributes.merge({user_id: user.id})
        
        expect(json_response).to have_key(:errors)
        should respond_with 422
      end
    end
  end

  describe "PUT/PATCH #update" do
    context "when is successfully updated" do
      it "renders the json representation for the updated label" do
        user = FactoryGirl.create :user
        label = FactoryGirl.create :label, user: user
        
        api_authorization_header user.auth_token_for_web

        serializer = LabelSerializer.new label
        adapter = ActiveModel::Serializer::Adapter::JsonApi.new serializer

        label_attributes = adapter.serializable_hash
        label_attributes[:data][:attributes][:title] = "Changed label title"

        patch :update, label_attributes.merge({ id: label.id })
        
        expect(json_response[:data][:attributes][:title]).to eql "Changed label title"
        should respond_with 200
      end
    end

    context "when is not updated" do
      it "renders an errors json" do
        user = FactoryGirl.create :user
        label = FactoryGirl.create :label, user: user
        
        api_authorization_header user.auth_token_for_web

        serializer = LabelSerializer.new label
        adapter = ActiveModel::Serializer::Adapter::JsonApi.new serializer

        invalid_label_attributes = adapter.serializable_hash
        invalid_label_attributes[:data][:attributes][:title] = ""

        patch :update, invalid_label_attributes.merge({ id: label.id })

        expect(json_response).to have_key(:errors)
        should respond_with 422
      end
    end
  end
end
