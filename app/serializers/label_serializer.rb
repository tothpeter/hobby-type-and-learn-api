class LabelSerializer < ActiveModel::Serializer
  attributes :title, :position, :user_id

  belongs_to :user
end
