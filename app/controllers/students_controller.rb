class StudentsController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        students = Student.all
        render json: students, status: :ok
    end

    def show
        student = Student.find( params[:id] )
        render json: student, status: :ok
    end

    def create
        student = Student.create!( student_params )
        render json: student, status: :created
    end

    def destroy
        student = Student.find_by( id: params[:id] )
        if student
            student.destroy
            render json: student, status: :ok
        else
            render json: { errors: ["Student not found."] }, status: 404
        end
    end


    private

    def student_params
        params.require( :student ).permit( :name, :age, :instructor_id, :major )
    end

    def render_not_found_response
        render json: { errors: ['Record not found.'] }, status: :not_found
    end

    def render_unprocessable_entity_response invalid
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
