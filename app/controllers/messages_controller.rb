class MessagesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        messages = Message.all
        render json: messages
    end

    def show
        message = find_message
        render json: message
    end
    
    def create
        message = Message.create!(message_params)
        render json: message, status: :created
    end

    def destroy
        activity = find_message
        activity.destroy
        head :no_content
    end

    private

    def message_params
        params.permit(:content, :friendship_id)
    end

    def find_message
        Message.find(params[:id])
    end

    def render_not_found_response
        render json: { error: "Message not found"}, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
