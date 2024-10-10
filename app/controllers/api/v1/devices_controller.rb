module Api::V1
    class DevicesController < ApplicationController
        skip_before_action :authorized

        def index
            @devices = Device.all
            render json: @devices
        end

        def show
            @device = Device.find(params[:id])
            render json: @device
        end

        def create
            @device = Device.create!(device_params)
            render json: @device, status: :created
        end

        def update
            @device = Device.find(params[:id])
            @device.update!(device_params)
            render json: @device, status: :accepted
        end

        def destroy
            @device = Device.find(params[:id])
            @device.destroy
            render json: { message: 'Device deleted' }, status: :ok
        end

        def device_user
            @devices = Device.where(user_id: params[:user_id])
            if @devices.empty?
                render json: { message: 'Devices not found' }, status: :not_found
            else
                render json: @devices
            end     
        end

        def device_by_identifier
            @devices = Device.where(device_identifier: params[:device_identifier])
            if @devices.empty?
                render json: { message: 'Devices not found' }, status: :not_found
            else
                render json: @devices
            end
        end

        private

        def device_params
            params.permit(:device_name, :device_identifier, :user_id)
        end
    end
end