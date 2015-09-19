class Api::V1::LabelCardsController < ApplicationController
  before_action :authenticate_with_token

  def create
    label = current_user.labels.find params[:label_id]
    card = current_user.cards.find params[:card_id]

    if label.card_ids = label.card_ids << card.id
      render nothing: true, status: 201
    else
      render status: 422
    end
  end
end
