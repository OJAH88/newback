class PostSerializer < ActiveModel::Serializer
  attributes :id, :content, :imgurl, :created_at, :user_id
  has_one :user
end
