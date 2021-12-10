class PokeSerializer < ActiveModel::Serializer
  attributes :id
  has_one :users
end
