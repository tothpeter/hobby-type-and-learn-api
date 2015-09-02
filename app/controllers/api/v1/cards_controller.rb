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
end
