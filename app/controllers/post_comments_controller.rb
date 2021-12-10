class PostCommentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        postcomments = Postcomment.all
        render json: postcomments
    end

    def show
        postcomment = find_postcomment
        render json: postcomment
    end

    def create
        postcomment = Postcomment.create!(postcomment_params)
        render json: postcomment, status: :created
    end

    def update
        postcomment = find_postcomment
        postcomment.update(postcomment_params)
        render json: postcomment
    end

    def destroy
        postcomment = find_postcomment
        postcomment.destroy
        head :no_content
    end

    private

    def postcomment_params
        postcomment.permit(:content, :imgurl, :user_id)
    end

    def find_postcomment
        Postcomment.find(params[:id])
    end

    def render_not_found_response
        render json: { error: "Post Comment not found"}, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end