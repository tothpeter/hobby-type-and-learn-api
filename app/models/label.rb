class Label < ActiveRecord::Base
  belongs_to :user

  has_many :label_cards, dependent: :destroy
  has_many :cards, through: :label_cards

  validates :title, presence: true
end
