class ReviewsController < ApplicationController
    skip_before_action :authenticated_user, only: [:index, :show]

    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :invalid

    def index
        render json: Review.all, status: :ok
    end

    def show
        render json: Review.find(params[:id]), status: :ok
    end

    def create
        # byebug
        newReview = @current_user.reviews.create!(review_params)
        render json: newReview, status: :created
    end

    def update
        review = Review.find(params[:id])
        if review.user == @current_user
            review.update!(review_params)
            render json: review, status: :accepted
        else
            render json: { errors: "Not authorized, not your review!" }, status: :unauthorized
        end
    end

    def destroy
        render json: Review.find(params[:id]).destroy!
        head :no_content
    end

    private

    def review_params
        params.permit(:user_id, :course_id, :pros, :cons, :rating)
    end

    def not_found
        render json: { error: "Review not found" }, status: :not_found
    end

end







    

