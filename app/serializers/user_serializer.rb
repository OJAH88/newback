class UserSerializer < ActiveModel::Serializer
  attributes :id, :password_digest, :name, :username, :age, :friends_count, :pokes_count, :posts_count, :city, :state, :bio, :hobbies, :likes
end
