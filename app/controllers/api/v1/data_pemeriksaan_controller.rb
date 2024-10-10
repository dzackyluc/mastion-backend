module Api::V1
    class DataPemeriksaanController < ApplicationController
        skip_before_action :authorized
        before_action :validate_dates, only: [:summary_by_date_kandang, :summary_by_date_sapi]

        def show
            @data_pemeriksaan = DataPemeriksaan.find(params[:id])
            render json: @data_pemeriksaan
        end

        def create
            @data_pemeriksaan = DataPemeriksaan.create!(data_pemeriksaan_params)
            render json: @data_pemeriksaan, status: :created
        end

        def update
            @data_pemeriksaan = DataPemeriksaan.find(params[:id])
            @data_pemeriksaan.update!(data_pemeriksaan_params)
            render json: @data_pemeriksaan, status: :accepted
        end

        def destroy
            @data_pemeriksaan = DataPemeriksaan.find(params[:id])
            @data_pemeriksaan.destroy
            render json: { message: 'Data Pemeriksaan deleted' }, status: :ok
        end

        def data_pemeriksaan_sapi
            @data_pemeriksaans = DataPemeriksaan.where(data_sapi_id: params[:data_sapi_id])
            render json: @data_pemeriksaans
        end

        def data_pemeriksaan_sapi_latest
            @data_pemeriksaans = DataPemeriksaan.where(data_sapi_id: params[:data_sapi_id]).order(created_at: :desc)
            if @data_pemeriksaans.any?
            render json: @data_pemeriksaans
            else
            render json: { message: 'Data Pemeriksaan not found' }, status: :not_found
            end
        end

        def data_pemeriksaan_sapi_by_kandang
            @data_pemeriksaans = DataPemeriksaan.where(data_kandang_id: params[:data_kandang_id])
            if @data_pemeriksaans.count > 0
                render json: @data_pemeriksaans
            else
                render json: { message: 'Data Pemeriksaan not found' }, status: :not_found
            end
        end

        def summary_by_date_kandang
            @data_pemeriksaans = DataPemeriksaan.where(data_kandang_id: params[:data_kandang_id]).where("created_at >= ?", params[:start_date]).where("created_at <= ?", params[:end_date])
            if @data_pemeriksaans.count > 0
                render json: @data_pemeriksaans
            else
                render json: { message: 'Data Pemeriksaan not found' }, status: :not_found
            end
        end

        def summary_by_date_sapi
            @data_pemeriksaans = DataPemeriksaan.where(data_sapi_id: params[:data_sapi_id]).where("created_at >= ?", params[:start_date]).where("created_at <= ?", params[:end_date])
            if @data_pemeriksaans.count > 0
                render json: @data_pemeriksaans
            else
                render json: { message: 'Data Pemeriksaan not found' }, status: :not_found
            end
        end

        private

        def data_pemeriksaan_params
            params.permit(:data_sapi_id, :data_kandang_id, :suhu, :confidence, :sel_somatik, :device_identifier)
        end

        def validate_dates
            begin
            start_date = params[:start_date] || params[:date][:start_date]
            end_date = params[:end_date] || params[:date][:end_date]
            Date.strptime(params[:start_date], '%Y-%m-%d')
            Date.strptime(params[:end_date], '%Y-%m-%d')
            rescue ArgumentError
            render json: { message: 'Invalid date format. Please use YYYY-MM-DD.' }, status: :bad_request
            end
        end
    end
end