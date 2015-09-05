class Card < ActiveRecord::Base
  belongs_to :user
  has_many :label_cards, dependent: :destroy
  has_many :labels, through: :label_cards

  validates_presence_of :side_a, :side_b
end
