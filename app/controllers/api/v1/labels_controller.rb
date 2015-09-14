class Api::V1::LabelsController < ApplicationController
  before_action :authenticate_with_token, only: [:create, :update, :destroy]

  def create
    label = current_user.labels.build label_params

    if label.save
      render json: label, status: 201
    else
      render json: { errors: label.errors }, status: 422
    end
  end

  def update
    label = current_user.labels.find params[:id]

    if label.update_attributes label_params
      render json: label, status: 200
    else
      render json: { errors: label.errors }, status: 422
    end
  end

  def destroy
    label = current_user.labels.find params[:id]
    label.destroy
    head 204
  end

  protected

  def label_params
    params[:data].require(:attributes).permit(:title, :position)
  end
end
