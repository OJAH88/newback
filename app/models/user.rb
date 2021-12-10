class User < ApplicationRecord
    has_secure_password

    has_many :friendships, dependent: :destroy
    has_many :friends, :through => :friendships
    has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
    has_many :inverse_friends, :through => :inverse_friendships, :source => :user
    has_many :posts
    has_many :comments, through: :posts
    has_many :pokes
    has_many :messages, through: :friendships

    

    validates :email, presence: true, uniqueness: true
    validates :password, presence: true


    def friendslist
        friends_array = friendships.map{|friendship| friendship.friend if friendship.confirmed} + inverse_friendships.map{|friendship| friendship.user if friendship.confirmed}
        friends_array.compact
    end

    def self.accept(user, friend)
        transaction do
            accepted_at = Time.now
            accept_one_side(user, friend, accepted_at)
            accept_one_side(friend, user, accepted_at)
        end
    end

    def self.accept_one_side(user, friend, accepted_at)
        request = find_by_user_id_and_friend_id(user, friend)
        request.status = "accepted"
        request.accepted_at = accepted_at
        request.save!
    end
   
    def friend?(user)
        friends.include?(user)
    end

end