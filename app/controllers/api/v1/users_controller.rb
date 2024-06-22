module Api::V1
    class UsersController < ApplicationController
        skip_before_action :authorized, only: [:create]
        rescue_from ActiveRecord::RecordInvalid, with: :Handle_invalid_record
        before_action :adjust_params, only: [:update]

        def create
            user = User.create!(user_params)
            @token = encode_token(user_id: user.id)
            render json: { user: UserSerializer.new(user), token: @token }, status: :created
        end

        def update
            user = User.find(params[:id])
            user.update!(user_update_params)
            render json: user, status: :ok
        end

        def all_users
            @users = User.all
            render json: @users, status: :ok
        end

        def delete
            user = User.find(params[:id])
            user.destroy
            render json: { message: 'User deleted' }, status: :ok
        end

        def me
            render json: session_user, status: :ok
        end

        private

        def adjust_params
            params[:bio] = nil if params[:bio].blank?
        end

        def user_params
            params.permit(:username, :email, :phone_number, :password)
        end

        def user_update_params
            params.permit(:username, :email, :bio, :phone_number, :image)
        end

        def Handle_invalid_record(invalid)
            render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
        end
    end
end
