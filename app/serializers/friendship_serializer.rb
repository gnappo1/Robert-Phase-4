class FriendshipSerializer < ActiveModel::Serializer
  attributes :id, :status
  has_one :recipient_id
  has_one :sender_id
end
