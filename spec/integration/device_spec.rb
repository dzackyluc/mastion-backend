require 'swagger_helper'

RSpec.describe 'Device API', type: :request do
    path '/api/v1/device' do
        post 'Creates a device' do
            tags 'Devices'
            consumes 'application/json'
            parameter name: :device, in: :body, schema: {
                type: :object,
                properties: {
                    device_name: { type: :string },
                    device_identifier: { type: :string },
                    user_id: { type: :integer }
                },
                required: ['device_name', 'device_identifier', 'user_id']
            }

            response '201', 'device created' do
                let(:user) { User.create(username: 'testuser', password: 'password') }
                let(:device) { { device_name: 'Device 1', device_identifier: '12345', user_id: user.id } }
                run_test!
            end
        end
    end

    path '/api/v1/device/{id}' do
        put 'Updates a device' do
            tags 'Devices'
            consumes 'application/json'
            parameter name: :id, in: :path, type: :string
            parameter name: :device, in: :body, schema: {
                type: :object,
                properties: {
                    device_name: { type: :string },
                    device_identifier: { type: :string },
                    user_id: { type: :integer }
                },
                required: ['device_name', 'device_identifier', 'user_id']
            }

            response '202', 'device updated' do
                let(:user) { User.create(username: 'testuser', password: 'password') }
                let(:existing_device) { Device.create(device_name: 'Device 1', device_identifier: '12345', user: user) }
                let(:id) { existing_device.id }
                let(:device) { { device_name: 'Updated Device', device_identifier: '67890', user_id: user.id } }
                run_test!
            end

            response '404', 'device not found' do
                let(:id) { 'invalid' }
                let(:device) { { device_name: 'Device 2', device_identifier: '67890', user_id: 1 } }
                run_test!
            end
        end

        delete 'Deletes a device' do
            tags 'Devices'
            parameter name: :id, in: :path, type: :string

            response '200', 'device deleted' do
                let(:user) { User.create(username: 'testuser', password: 'password') }
                let!(:device) { Device.create(device_name: 'Device 1', device_identifier: '12345', user: user) }
                let(:id) { device.id }
                run_test!
            end

            response '404', 'device not found' do
                let(:id) { 'invalid' }
                run_test!
            end
        end
    end

    path '/api/v1/device/{user_id}' do
        get 'Retrieves devices by user' do
            tags 'Devices'
            produces 'application/json'
            parameter name: :user_id, in: :path, type: :integer

            response '200', 'devices found' do
                schema type: :array,
                    items: {
                        type: :object,
                        properties: {
                            id: { type: :integer },
                            device_name: { type: :string },
                            device_identifier: { type: :string },
                            user_id: { type: :integer }
                        },
                        required: ['id', 'device_name', 'device_identifier', 'user_id']
                    }

                let(:user) { User.create(username: 'testuser', password: 'password') }
                let!(:device) { Device.create(device_name: 'Test Device', device_identifier: '12345', user: user) }
                let(:user_id) { user.id }
                
                run_test!
            end

            response '404', 'devices not found' do
                let(:user_id) { -1 }
        
                run_test!
            end
        end
    end

    path '/api/v1/device/identifier/{device_identifier}' do
        get 'Retrieves devices by identifier' do
            tags 'Devices'
            produces 'application/json'
            parameter name: :device_identifier, in: :path, type: :string

            response '200', 'devices found' do
                schema type: :array,
                    items: {
                        type: :object,
                        properties: {
                            id: { type: :integer },
                            device_name: { type: :string },
                            device_identifier: { type: :string },
                            user_id: { type: :integer }
                        },
                        required: ['id', 'device_name', 'device_identifier', 'user_id']
                    }

                let(:user) { User.create(username: 'testuser', password: 'password') }
                let!(:device) { Device.create(device_name: 'Test Device', device_identifier: '12345', user: user) }
                let(:device_identifier) { device.device_identifier }
                run_test!
            end

            response '404', 'devices not found' do
                let(:device_identifier) { 'nonexistent' }
                run_test!
            end
        end
    end
end