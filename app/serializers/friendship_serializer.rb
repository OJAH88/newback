class FriendshipSerializer < ActiveModel::Serializer
  attributes :id
  has_one :users
end
