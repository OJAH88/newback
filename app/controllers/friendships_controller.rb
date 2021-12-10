class FriendshipsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        friendships = Friendship.all
        render json: friendships
    end
      
    def show
        friendship = find_friendship
        render json: friendship
    end

    def create
        friendship = Friendship.create!(friendship_params)
        render json: friendship, status: :created
        friendship.save!
    end
    
    def destroy
        friendship = find_friendship
        friendship.destroy 
        head :no_content
    end
    
    private

    def find_friendship
        Friendship.find(friendship_params)
    end
    
    def friendship_params
        params.permit(:id)
    end

    def render_not_found_response
        render json: { error: "Friendship not found"}, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
