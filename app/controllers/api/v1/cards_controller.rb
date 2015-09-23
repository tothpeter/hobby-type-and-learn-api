class Api::V1::CardsController < ApplicationController
  before_action :authenticate_with_token

  has_scope :sort do |controller, scope, value|
    if ["side_a", "side_b", "proficiency_level"].include?(value) && ["desc", "asc"].include?(controller.params[:sort_order])
      scope.order("#{value} #{controller.params[:sort_order]}")
    end
  end

  def index
    if params[:label_id]
      label = Label.find params[:label_id]
      cards = apply_scopes(label.cards).page(params[:page]).per(3)
    else
      cards = apply_scopes(current_user.cards).page(params[:page]).per(3)
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

  def update
    card = current_user.cards.find params[:id]

    if card.update_attributes card_params
      update_relationship card
      render json: card, status: 200
    else
      render json: { errors: card.errors }, status: 422
    end
  end

  def destroy
    card = current_user.cards.find params[:id]
    card.destroy
    head 204
  end

  def import
    Card.import params[:file], current_user
    render json: {}, status: 201
  end

  protected

  def card_params
    params[:data].require(:attributes).permit(:side_a, :side_b, :proficiency_level)
  end

  def save_relationship card
    if params[:data][:relationships] && params[:data][:relationships][:labels] && params[:data][:relationships][:labels][:data]
      card.label_ids = params[:data][:relationships][:labels][:data].collect {|label| label[:id].to_i}
    end
  end

  def update_relationship card
    if params[:data][:relationships] && params[:data][:relationships][:labels]
      if params[:data][:relationships][:labels][:data]
        card.label_ids = params[:data][:relationships][:labels][:data].collect {|label| label[:id].to_i}
      else
        card.label_ids = []
      end
    end
  end
end
