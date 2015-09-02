class LabelCard < ActiveRecord::Base
  self.table_name = "labels_cards"

  belongs_to :label, inverse_of: :label_cards
  belongs_to :card, inverse_of: :label_cards
end
