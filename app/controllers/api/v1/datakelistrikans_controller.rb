module Api::V1
    class DatakelistrikansController < ApplicationController
        skip_before_action :authorized, only: [:create, :update, :all_data_kelistrikan]
        rescue_from ActiveRecord::RecordInvalid, with: :Handle_invalid_record

        def create
            data_kelistrikans = DataKelistrikan.create!(data_kelistrikan_params)
            render json: data_kelistrikans, status: :created
        end

        def update
            data_kelistrikans = DataKelistrikan.find(params[:id])
            data_kelistrikans.update!(data_kelistrikan_update_params)
            render json: data_kelistrikans, status: :ok
        end

        def all_data_kelistrikan
            @data_kelistrikans = DataKelistrikan.all
            render json: @data_kelistrikans, status: :ok
        end

        def delete
            data_kelistrikans = DataKelistrikan.find(params[:id])
            data_kelistrikans.destroy
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