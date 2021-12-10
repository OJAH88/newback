class UsersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    skip_before_action :authorize
  
    # def index
    #     users = User.all
    #     render json: users
    # end

    def show
        # user = find_user
        # if user
        #     render json: user, status: :ok
        # else
        #     render json: "Not authenticated", status: :unauthorized
        # end
        render json: @current_user
    end

    def create
    user = User.create!(user_params)
    session[:user_id] = user.id
    render json: user, status: :created
    end

    private
  
    def user_params
      params.permit(:username, :password, :password_confirmation, :name, :email, :age, :friends_count, :pokes_count, :messages_count, :city, :state, :bio, :hobbies, :likes, :imgurl)
    end

    def render_not_found_response
        render json: { error: "User not found"}, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
  
    def find_user
        User.find(params[:id])
    end
  end