module Api::V1
    class DataPemeriksaanController < ApplicationController
        def index
            @data_pemeriksaans = DataPemeriksaan.all
            render json: @data_pemeriksaans
        end

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
            @data_pemeriksaan = DataPemeriksaan.where(data_sapi_id: params[:data_sapi_id]).last
            render json: @data_pemeriksaan
        end

        def data_pemeriksaan_sapi_by_kandang
            @data_pemeriksaans = DataPemeriksaan.where(data_kandang_id: params[:data_kandang_id])
            render json: @data_pemeriksaans
        end

        def summary_pemeriksaan
            @data_pemeriksaans = DataPemeriksaan.where(data_sapi_id: params[:data_sapi_id])
            @total_pemeriksaan = @data_pemeriksaans.count
            @total_pemeriksaan_normal = @data_pemeriksaans.where("confidence >= ?", 0.8).count
            @total_pemeriksaan_abnormal = @data_pemeriksaans.where("confidence < ?", 0.8).count
            @total_pemeriksaan_somatik = @data_pemeriksaans.where("sel_somatik > ?", 200.000).count
            render json: { total_pemeriksaan: @total_pemeriksaan, total_pemeriksaan_normal: @total_pemeriksaan_normal, total_pemeriksaan_abnormal: @total_pemeriksaan_abnormal, total_pemeriksaan_somatik: @total_pemeriksaan_somatik }
        end

        def summary_pemeriksaan_kandang
            @data_pemeriksaans = DataPemeriksaan.where(data_kandang_id: params[:data_kandang_id])
            @total_pemeriksaan = @data_pemeriksaans.count
            @total_pemeriksaan_suhu_normal = @data_pemeriksaans.where("suhu >= ?", 35.000).where("suhu <= ?", 39.000).count
            @total_pemeriksaan_suhu_tinggi = @data_pemeriksaans.where("suhu > ?", 39.000).count
            @total_pemeriksaan_normal = @data_pemeriksaans.where("confidence >= ?", 0.8).count
            @total_pemeriksaan_abnormal = @data_pemeriksaans.where("confidence < ?", 0.8).count
            @total_pemeriksaan_somatik = @data_pemeriksaans.where("sel_somatik > ?", 200.000).count
            @total_pemeriksaan_sapi = @data_pemeriksaans.select(:data_sapi_id).distinct.count
            render json: { total_pemeriksaan: @total_pemeriksaan, total_pemeriksaan_suhu_normal: @total_pemeriksaan_suhu_normal, total_pemeriksaan_suhu_tinggi: @total_pemeriksaan_suhu_tinggi, total_pemeriksaan_normal: @total_pemeriksaan_normal, total_pemeriksaan_abnormal: @total_pemeriksaan_abnormal, total_pemeriksaan_somatik: @total_pemeriksaan_somatik, total_pemeriksaan_sapi: @total_pemeriksaan_sapi }
        end

        private

        def data_pemeriksaan_params
            params.permit(:data_sapi_id, :data_kandang_id, :suhu, :confidence, :sel_somatik, :device_identifier)
        end
    end
end