class InstructorsController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        instructors = Instructor.all
        render json: instructors, status: :ok
    end




    private

    def instructor_params
        params.require( :instructor ).permit( :name )
    end

    def render_not_found_response invalid
        render json: { errors: invalid.record.errors.full_messages }, status: :not_found
    end

    def render_unprocessable_entity_response invalid
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end


end
