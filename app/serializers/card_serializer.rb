class CardSerializer < BaseSerializer
  attributes :side_a, :side_b, :proficiency_level

  belongs_to :user
end
