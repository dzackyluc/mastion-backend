module Api::V1
    class DatamcuController < ApplicationController
        skip_before_action :authorized, only: [:index, :show, :create]

        def index
            @datamcus = Datamcu.all
            render json: @datamcus
        end

        def show
            @datamcu = Datamcu.find(params[:id])
            render json: @datamcu
        end

        def create
            @datamcu = Datamcu.create!(datamcu_params)
            render json: @datamcu
        end

        def update
            @datamcu = Datamcu.find(params[:id])
            @datamcu.update!(datamcu_params)
            render json: @datamcu
        end

        def destroy
            @datamcu = Datamcu.find(params[:id])
            @datamcu.destroy
            render json: { message: 'Datamcu deleted' }
        end

        private

        def datamcu_params
            params.permit(:name, :description, :price, :image_url, :category_id)
        end
    end
end