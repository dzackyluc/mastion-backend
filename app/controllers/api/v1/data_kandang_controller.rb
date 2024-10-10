module Api::V1
    class DataKandangController < ApplicationController

        def index
            @data_kandangs = DataKandang.all
            render json: @data_kandangs
        end

        def show
            @data_kandang = DataKandang.find(params[:id])
            render json: @data_kandang
        end

        def create
            @data_kandang = DataKandang.create!(data_kandang_params)
            render json: @data_kandang, status: :created
        end

        def update
            @data_kandang = DataKandang.find(params[:id])
            @data_kandang.update!(data_kandang_params)
            render json: @data_kandang, status: :accepted
        end

        def destroy
            @data_kandang = DataKandang.find(params[:id])
            @data_kandang.destroy
            render json: { message: 'Data Kandang deleted' }, status: :ok
        end

        def data_kandang_user
            @data_kandangs = DataKandang.where(user_id: params[:user_id])
            if @data_kandangs.empty?
                render json: { message: 'Data Kandang not found' }, status: :not_found
            else
                render json: @data_kandangs
            end
        end

        private

        def data_kandang_params
            params.permit(:nama_kandang, :kapasitas, :description, :user_id)
        end
    end
end