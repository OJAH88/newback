class PokesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    
    def show
        poke = find_poke
        render json: poke
    end
    
    def create
        poke = Poke.create!(poke_params)
        render json: poke, status: :created
    end


    private

    def poke_params
        params.permit(:user_id)
    end

    def find_poke
        Poke.find(params[:id])
    end

    def render_not_found_response
        render json: { error: "Poke not found"}, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end
