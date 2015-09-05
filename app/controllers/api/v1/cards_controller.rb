class Api::V1::CardsController < ApplicationController
  before_action :authenticate_with_token

  def index
    if params[:label_id]
      label = Label.find params[:label_id]
      cards = label.cards.page(params[:page]).per(3)
    else
      cards = current_user.cards.page(params[:page]).per(3)
    end
    render json: cards, serializer: PaginatedSerializer
  end

  def create
    card = current_user.cards.build card_params

    if card.save
      save_relationship card
      render json: card, status: 201
    else
      render json: { errors: card.errors }, status: 422
    end
  end

  protected

  def card_params
    params[:data].require(:attributes).permit(:side_a, :side_b, :proficiency_level)
  end

  def save_relationship card
    if params[:data][:relationships] && params[:data][:relationships][:labels]
      card.label_ids = params[:data][:relationships][:labels][:data].collect {|label| label[:id].to_i}
    end
  end
end
