class UsersController < ApplicationController
    skip_before_action :authenticated_user, only: [:create, :show]
    before_action :authorize, only: [:update, :destroy]

    rescue_from ActiveRecord::RecordInvalid, with: :RecordInvalid
    rescue_from ActiveRecord::RecordNotFound, with: :not_found




    def create
        user = User.create!(user_params)
        session[:user_id] = user.ID
        render json: user, status: :created
    end

    def show
        if params[:id]
            render json: User.find(params[:id]), status: :ok, serializer: UserReviewSerializer
        else
            render json: @current_user, status: :ok

        end

        def index
            render json: User.all, status: :ok

        end


        def updated
            updated_user = User.find(params[:id])
            updated_user.update!(user_params)
            render json: updated_user, status: :accepted
        end

        def destroy
            render json: User.find(params[:id]).destroy!
            head: no_content
        end


        private

        def user_params
            params.permit(:name, :password, :image, :email)
        end

        def not_found
            render json: { error: "User not found" }, status: :not_found
        end

        def authorize
            return render json: { error: "Not authorized" }, status: unauthorized unless session[:user_id] == @current_user.ID
        end

end
