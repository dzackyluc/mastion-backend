require 'swagger_helper'

RSpec.describe 'Data Kandang API', type: :request do
    let(:user) { User.create!(username: 'Test User', email: 'test@example.com',phone_number: "089658028496", password: 'password') }
    let(:token) { user.token }

    before(:each) do
        user
        allow_any_instance_of(ApplicationController).to receive(:session_user).and_return(user)
        allow_any_instance_of(ApplicationController).to receive(:authorized).and_return(true)
    end

    path '/api/v1/kandang/{user_id}' do
        get 'Retrieves all kandangs for a user' do
            tags 'Data Kandang'
            produces 'application/json'
            parameter name: :user_id, in: :path, type: :string, description: 'User ID'
            security [bearer_auth: []]

            response '200', 'kandangs found' do
                schema type: :array,
                             items: {
                                 type: :object,
                                 properties: {
                                     id: { type: :integer },
                                     nama_kandang: { type: :string },
                                     kapasitas: { type: :integer },
                                     description: { type: :string },
                                     user_id: { type: :integer }
                                 },
                                 required: %w[id nama_kandang kapasitas description user_id]
                             }

                let!(:kandang) { DataKandang.create(nama_kandang: 'Kandang A', kapasitas: 100, description: 'Deskripsi Kandang A', user_id: user.id) }
                let(:user_id) { user.id }
                
                run_test!
            end

            response '404', 'kandangs not found' do
                let(:user_id) { 'invalid' }
                run_test!
            end
        end
    end

    path '/api/v1/kandang' do
        post 'Creates a kandang' do
            tags 'Data Kandang'
            consumes 'application/json'
            parameter name: :kandang, in: :body, schema: {
                type: :object,
                properties: {
                    nama_kandang: { type: :string },
                    kapasitas: { type: :integer },
                    description: { type: :string },
                    user_id: { type: :integer }
                },
                required: %w[nama_kandang kapasitas description user_id]
            }
            security [bearer_auth: []]

            response '201', 'kandang created' do
                let(:kandang) { { nama_kandang: 'Kandang A', kapasitas: 100, description: 'Deskripsi Kandang A', user_id: user.id } }
                run_test!
            end

            response '422', 'invalid request' do
                let(:kandang) { { nama_kandang: 'Kandang A' } }
                run_test!
            end
        end
    end

    path '/api/v1/kandang/{id}' do
        put 'Updates a kandang' do
            tags 'Data Kandang'
            consumes 'application/json'
            parameter name: :id, in: :path, type: :string, description: 'Kandang ID'
            parameter name: :kandang, in: :body, schema: {
                type: :object,
                properties: {
                    nama_kandang: { type: :string },
                    kapasitas: { type: :integer },
                    description: { type: :string },
                    user_id: { type: :integer }
                },
                required: %w[nama_kandang kapasitas description user_id]
            }
            security [bearer_auth: []]

            response '202', 'kandang updated' do
                let(:id) { DataKandang.create(nama_kandang: 'Kandang A', kapasitas: 100, description: 'Deskripsi Kandang A', user_id: user.id).id }
                let(:kandang) { { nama_kandang: 'Kandang B', kapasitas: 150, description: 'Deskripsi Kandang B', user_id: user.id } }
                run_test!
            end

            response '404', 'kandang not found' do
                let(:id) { 'invalid' }
                let(:kandang) { { nama_kandang: 'Kandang B', kapasitas: 150, description: 'Deskripsi Kandang B', user_id: user.id } }
                run_test!
            end
        end

        delete 'Deletes a kandang' do
            tags 'Data Kandang'
            parameter name: :id, in: :path, type: :string, description: 'Kandang ID'
            security [bearer_auth: []]

            response '200', 'kandang deleted' do
                let(:id) { DataKandang.create(nama_kandang: 'Kandang A', kapasitas: 100, description: 'Deskripsi Kandang A', user_id: user.id).id }
                run_test!
            end

            response '404', 'kandang not found' do
                let(:id) { 'invalid' }
                run_test!
            end
        end
    end
end