require 'swagger_helper'

RSpec.describe 'Data Pemeriksaan API', type: :request do
    let!(:user) { User.create!(username: 'Test User', email: 'test@example.com',phone_number: "089658028496", password: 'password') }
    let!(:data_kandang) { DataKandang.create(nama_kandang: 'Kandang 1', kapasitas: 100, description: 'Deskripsi Kandang', user_id: user.id) }
    let!(:data_sapi) { DataSapi.create(bangsa: 'Sapi Bali', bobot: "500", data_kandang_id: data_kandang.id) }

    path '/api/v1/pemeriksaan' do
        post 'Creates a Data Pemeriksaan' do
            tags 'Data Pemeriksaan'
            consumes 'application/json'
            parameter name: :data_pemeriksaan, in: :body, schema: {
                type: :object,
                properties: {
                    data_sapi_id: { type: :integer },
                    data_kandang_id: { type: :integer },
                    suhu: { type: :string },
                    confidence: { type: :string },
                    sel_somatik: { type: :string },
                    device_identifier: { type: :string }
                },
                required: [ 'data_sapi_id', 'data_kandang_id', 'suhu', 'confidence', 'sel_somatik', 'device_identifier' ]
            }

            response '201', 'data pemeriksaan created' do
                let(:data_pemeriksaan) { { data_sapi_id: data_sapi.id, data_kandang_id: data_kandang.id, suhu: "37.5", confidence: "0.9", sel_somatik: "150000", device_identifier: 'device123' } }
                run_test!
            end

            response '422', 'invalid request' do
                let(:data_pemeriksaan) { { data_sapi_id: nil } }
                run_test!
            end
        end
    end

    path '/api/v1/pemeriksaan/{id}' do
        put 'Updates a Data Pemeriksaan' do
            tags 'Data Pemeriksaan'
            consumes 'application/json'
            parameter name: :id, in: :path, type: :integer
            parameter name: :data_pemeriksaan, in: :body, schema: {
                type: :object,
                properties: {
                    data_sapi_id: { type: :integer },
                    data_kandang_id: { type: :integer },
                    suhu: { type: :string },
                    confidence: { type: :string },
                    sel_somatik: { type: :string },
                    device_identifier: { type: :string }
                },
                required: [ 'data_sapi_id', 'data_kandang_id', 'suhu', 'confidence', 'sel_somatik', 'device_identifier' ]
            }

            response '202', 'data pemeriksaan updated' do
                let(:id) { DataPemeriksaan.create(data_sapi_id: data_sapi.id, data_kandang_id: data_kandang.id, suhu: "37.5", confidence: "0.9", sel_somatik: "150000", device_identifier: 'device123').id }
                let(:data_pemeriksaan) { { suhu: "38.0" } }
                run_test!
            end

            response '404', 'data pemeriksaan not found' do
                let(:id) { 'invalid' }
                let(:data_pemeriksaan) { { suhu: "38.0" } }
                run_test!
            end
        end

        delete 'Deletes a Data Pemeriksaan' do
            tags 'Data Pemeriksaan'
            parameter name: :id, in: :path, type: :integer

            response '200', 'data pemeriksaan deleted' do
                let(:id) { DataPemeriksaan.create(data_sapi_id: data_sapi.id, data_kandang_id: data_kandang.id, suhu: 37.5, confidence: 0.9, sel_somatik: 150000, device_identifier: 'device123').id }
                run_test!
            end

            response '404', 'data pemeriksaan not found' do
                let(:id) { 'invalid' }
                run_test!
            end
        end
    end

    path '/api/v1/pemeriksaan/{data_sapi_id}' do
        get 'Retrieves all Data Pemeriksaan for a specific Sapi' do
            tags 'Data Pemeriksaan'
            produces 'application/json'
            parameter name: :data_sapi_id, in: :path, type: :integer

            response '200', 'data pemeriksaan found' do
                schema type: :array,
                items: {
                    type: :object,
                    properties: {
                        id: { type: :integer },
                        data_sapi_id: { type: :integer },
                        data_kandang_id: { type: :integer },
                        suhu: { type: :string },
                        confidence: { type: :string },
                        sel_somatik: { type: :string },
                        device_identifier: { type: :string }
                    },
                    required: [ 'id', 'data_sapi_id', 'data_kandang_id', 'suhu', 'confidence', 'sel_somatik', 'device_identifier' ]
                }

                before do
                    DataPemeriksaan.create!(data_sapi_id: data_sapi.id, data_kandang_id: data_kandang.id, suhu: "37.5", confidence: "0.9", sel_somatik: "150000", device_identifier: 'device123', created_at: Time.zone.parse('2024-10-11 12:00:00'))
                end

                let(:data_sapi_id) { data_sapi.id }
                run_test!
            end

            response '404', 'data pemeriksaan not found' do
                let(:data_sapi_id) { 'invalid' }
                run_test!
            end
        end
    end

    path '/api/v1/pemeriksaan/kandang/{data_kandang_id}' do
        get 'Retrieves all Data Pemeriksaan for a specific Kandang' do
            tags 'Data Pemeriksaan'
            produces 'application/json'
            parameter name: :data_kandang_id, in: :path, type: :integer

            response '200', 'data pemeriksaan found' do
                schema type: :array,
                    items: {
                        type: :object,
                        properties: {
                            id: { type: :integer },
                            data_sapi_id: { type: :integer },
                            data_kandang_id: { type: :integer },
                            suhu: { type: :string },
                            confidence: { type: :string },
                            sel_somatik: { type: :string },
                            device_identifier: { type: :string }
                        },
                        required: [ 'id', 'data_sapi_id', 'data_kandang_id', 'suhu', 'confidence', 'sel_somatik', 'device_identifier' ]
                    }

                before do
                    DataPemeriksaan.create!(data_sapi_id: data_sapi.id, data_kandang_id: data_kandang.id, suhu: "37.5", confidence: "0.9", sel_somatik: "150000", device_identifier: 'device123', created_at: Time.zone.parse('2024-10-11 12:00:00'))
                end

                let(:data_kandang_id) { data_kandang.id }
                run_test!
            end

            response '404', 'data pemeriksaan not found' do
                let(:data_kandang_id) { 'invalid' }
                run_test!
            end
        end
    end

    path '/api/v1/pemeriksaan/summary/kandang/{data_kandang_id}' do 
        get 'Retrieves summary of Data Pemeriksaan for a specific Kandang and date range' do
            tags 'Data Pemeriksaan'
            produces 'application/json'
            parameter name: :data_kandang_id, in: :path, type: :integer
            parameter name: :start_date, in: :query, type: :string
            parameter name: :end_date, in: :query, type: :string

            response '200', 'data pemeriksaan summary found' do
                schema type: :array,
                    items: {
                        type: :object,
                        properties: {
                            data_sapi_id: { type: :integer },
                            data_kandang_id: { type: :integer },
                            suhu: { type: :string },
                            confidence: { type: :string },
                            sel_somatik: { type: :string },
                            device_identifier: { type: :string }
                        },
                        required: [ 'data_sapi_id', 'data_kandang_id', 'suhu', 'confidence', 'sel_somatik', 'device_identifier' ]
                    }

                before do
                    DataPemeriksaan.create!(data_sapi_id: data_sapi.id, data_kandang_id: data_kandang.id, suhu: "37.5", confidence: "0.9", sel_somatik: "150000", device_identifier: 'device123', created_at: Time.zone.parse('2024-10-11 12:00:00'))
                end

                let(:data_kandang_id) { data_kandang.id }
                let(:start_date) { '2024-10-10' }
                let(:end_date) { '2024-10-13' }
                run_test!
            end

            response '404', 'data pemeriksaan summary not found' do
                let(:data_kandang_id) { 'invalid' }
                let(:start_date) { '2021-01-01' }
                let(:end_date) { '2021-01-02' }
                run_test!
            end

            response '400', 'invalid date format' do
                let(:data_kandang_id) { data_kandang.id }
                let(:start_date) { 'invalid' }
                let(:end_date) { 'invalid' }
                run_test!
            end
        end
    end

    path '/api/v1/pemeriksaan/summary/sapi/{data_sapi_id}' do
        get 'Retrieves summary of Data Pemeriksaan for a specific Sapi and date range' do
            tags 'Data Pemeriksaan'
            produces 'application/json'
            parameter name: :data_sapi_id, in: :path, type: :integer
            parameter name: :start_date, in: :query, type: :string
            parameter name: :end_date, in: :query, type: :string

            response '200', 'data pemeriksaan summary found' do
                schema type: :array,
                items: {
                    type: :object,
                    properties: {
                        data_sapi_id: { type: :integer },
                        data_kandang_id: { type: :integer },
                        suhu: { type: :string },
                        confidence: { type: :string },
                        sel_somatik: { type: :string },
                        device_identifier: { type: :string }
                    },
                    required: [ 'data_sapi_id', 'data_kandang_id', 'suhu', 'confidence', 'sel_somatik', 'device_identifier' ]
                }

                before do
                    DataPemeriksaan.create!(data_sapi_id: data_sapi.id, data_kandang_id: data_kandang.id, suhu: "37.5", confidence: "0.9", sel_somatik: "150000", device_identifier: 'device123', created_at: Time.zone.parse('2024-10-11 12:00:00'))
                end

                let(:data_sapi_id) { data_sapi.id }
                let(:start_date) { '2024-10-10' }
                let(:end_date) { '2024-10-13' }

                run_test!
            end

            response '404', 'data pemeriksaan summary not found' do
                let(:data_sapi_id) { 'invalid' }
                let(:start_date) { '2021-01-01' }
                let(:end_date) { '2021-01-02' }
                run_test!
            end

            response '400', 'invalid date format' do
                let(:data_sapi_id) { data_sapi.id }
                let(:start_date) { 'invalid-date' }
                let(:end_date) { 'invalid-date' }
                run_test!
            end
        end
    end
end