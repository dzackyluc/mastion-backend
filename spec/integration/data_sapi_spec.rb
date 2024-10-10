require 'swagger_helper'

RSpec.describe 'Data Sapi API', type: :request do
  let(:user) { User.create!(username: 'Test User', email: 'test@example.com',phone_number: "089658028496", password: 'password') }
  let(:token) { user.token }

  before(:each) do
    user
    allow_any_instance_of(ApplicationController).to receive(:session_user).and_return(user)
    allow_any_instance_of(ApplicationController).to receive(:authorized).and_return(true)
  end
  path '/api/v1/sapi' do
    post 'Creates Data Sapi' do
      tags 'Data Sapi'
      consumes 'application/json'
      parameter name: :data_sapi, in: :body, schema: {
        type: :object,
        properties: {
          bangsa: { type: :string },
          bobot: { type: :string },
          data_kandang_id: { type: :integer }
        },
        required: ['bangsa', 'bobot', 'data_kandang_id']
      }

      response '201', 'data sapi created' do
        let(:data_kandang) { DataKandang.create(nama_kandang: 'Kandang 1', kapasitas: 100, description: 'Deskripsi Kandang', user: User.first) }
        let(:data_sapi) { { bangsa: 'Sapi Bali', bobot: "500", data_kandang_id: data_kandang.id } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:data_sapi) { { bangsa: 'Sapi Bali' } }
        run_test!
      end
    end
  end

  path '/api/v1/sapi/{id}' do
    put 'Updates Data Sapi' do
      tags 'Data Sapi'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :data_sapi, in: :body, schema: {
        type: :object,
        properties: {
          bangsa: { type: :string },
          bobot: { type: :string },
          data_kandang_id: { type: :integer }
        },
        required: ['bangsa', 'bobot', 'data_kandang_id']
      }

      response '202', 'data sapi updated' do
        let(:data_kandang) { DataKandang.create(nama_kandang: 'Kandang 1', kapasitas: 100, description: 'Deskripsi Kandang', user: User.first) }
        let(:existing_data_sapi) { DataSapi.create(bangsa: 'Sapi', bobot: "500", data_kandang: data_kandang) }
        let(:id) { existing_data_sapi.id }
        let(:data_sapi) { { bangsa: 'Sapi Madura', bobot: "600", data_kandang_id: data_kandang.id } }
        run_test!
      end

      response '404', 'data sapi not found' do
        let(:id) { 'invalid' }
        let(:data_sapi) { { bangsa: 'Sapi Madura', bobot: "600", data_kandang_id: 1 } }
        run_test!
      end
    end

    delete 'Deletes Data Sapi' do
      tags 'Data Sapi'
      parameter name: :id, in: :path, type: :string

      response '200', 'data sapi deleted' do
        let(:data_kandang) { DataKandang.create(nama_kandang: 'Kandang 1', kapasitas: 100, description: 'Deskripsi Kandang', user: User.first) }
        let!(:data_sapi) { DataSapi.create(bangsa: 'Sapi Bali', bobot: "500", data_kandang: data_kandang) }
        let(:id) { data_sapi.id }
        run_test!
      end

      response '404', 'data sapi not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/sapi/{data_kandang_id}' do
    get 'Retrieves Data Sapi by Kandang' do
      tags 'Data Sapi'
      produces 'application/json'
      parameter name: :data_kandang_id, in: :path, type: :string
      security [bearer_auth: []]

      response '200', 'data sapi found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   bangsa: { type: :string },
                   bobot: { type: :string },
                   data_kandang_id: { type: :integer }
                 },
                 required: ['id', 'bangsa', 'bobot', 'data_kandang_id']
               }

        let(:data_kandang) { DataKandang.create(nama_kandang: 'Kandang 1', kapasitas: 100, description: 'Deskripsi Kandang', user: User.first) }
        let!(:data_sapi) { DataSapi.create(bangsa: 'Sapi Bali', bobot: "500",umur: "4 Tahun", data_kandang_id: data_kandang.id) }
        let(:data_kandang_id) { data_kandang.id }
        run_test!
      end

      response '404', 'data sapi not found' do
        let(:data_kandang_id) { 'invalid' }
        run_test!
      end
    end
  end
end