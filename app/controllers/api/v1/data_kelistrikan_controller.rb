module Api::V1
    class DatakelistrikanController < ApplicationController
        skip_before_action :authorized, only: [:create, :update, :all_data_kelistrikan]
        rescue_from ActiveRecord::RecordInvalid, with: :Handle_invalid_record

        def create
            data_kelistrikan = DataKelistrikan.create!(data_kelistrikan_params)
            render json: data_kelistrikan, status: :created
        end

        def update
            data_kelistrikan = DataKelistrikan.find(params[:id])
            data_kelistrikan.update!(data_kelistrikan_update_params)
            render json: data_kelistrikan, status: :ok
        end

        def all_data_kelistrikan
            @data_kelistrikan = DataKelistrikan.all
            render json: @data_kelistrikan, status: :ok
        end

        def delete
            data_kelistrikan = DataKelistrikan.find(params[:id])
            data_kelistrikan.destroy
            render json: { message: 'Data Kelistrikan deleted' }, status: :ok
        end

        private

        def data_kelistrikan_params
            params.permit(:data)
        end

        def data_kelistrikan_update_params
            params.permit(:data)
        end

        def Handle_invalid_record(invalid)
            render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
        end
    end
end