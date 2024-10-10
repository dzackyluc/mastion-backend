module Api::V1
    class DataSapiController < ApplicationController
        def index
            @data_sapis = DataSapi.all
            render json: @data_sapis
        end

        def show
            @data_sapi = DataSapi.find(params[:id])
            render json: @data_sapi
        end

        def create
            @data_sapi = DataSapi.create!(data_sapi_params)
            render json: @data_sapi, status: :created
        end

        def update
            @data_sapi = DataSapi.find(params[:id])
            @data_sapi.update!(data_sapi_params)
            render json: @data_sapi, status: :accepted
        end

        def destroy
            @data_sapi = DataSapi.find(params[:id])
            @data_sapi.destroy
            render json: { message: 'Data Sapi deleted' }, status: :ok
        end

        def data_sapi_kandang
            @data_sapis = DataSapi.where(data_kandang_id: params[:data_kandang_id])
            if @data_sapis.empty?
                render json: { message: 'Data Sapi not found' }, status: :not_found
            else
                render json: @data_sapis
            end
        end

        private

        def data_sapi_params
            params.permit(:bangsa, :bobot, :jenis_kelamin, :umur, :data_kandang_id)
        end
    end
end