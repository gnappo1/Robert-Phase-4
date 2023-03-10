class CoursesController < ApplicationController
    skip_before_action :authenticated_user, only: [:index, :show]

    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :invalid



    def index
        render json: Course.all, status: :ok
    end

    def show
        render json: Course.find(params[:id]), status: :ok, serializer: CourseReviewsSerializer
    end

    def create
        render json: Course.create!(course_params), status: :created
    end

    def update
        render json: Course.find(params[:id]).update!(course_params), status: :accepted
    end




    private

    # def render_courses
    #     render json: Course.all, status: :ok
    # end

    def course_params
        params.permit(:name, :location, :price, :holes, :par, :length, :img_url)
    end

    def not_found
        render json: { error: "Course not found" }, status: :not_found
    end
end
