require 'swagger_helper'

RSpec.describe 'Authentication API', type: :request do
    let(:user) { User.create!(username: 'Test User', email: 'test@example.com',phone_number: "089658028496", password: 'password') }
    let(:token) { user.token }

    before(:each) do
        user
        allow_any_instance_of(ApplicationController).to receive(:session_user).and_return(user)
        allow_any_instance_of(ApplicationController).to receive(:authorized).and_return(true)
    end

    path '/api/v1/login' do
        post 'Logs in a user' do
            tags 'Authentication'
            consumes 'application/json'
            parameter name: :credentials, in: :body, schema: {
                type: :object,
                properties: {
                    username: { type: :string },
                    password: { type: :string }
                },
                required: ['username', 'password']
            }

            response '202', 'user logged in' do
                let(:credentials) { { username: user.username, password: user.password } }
                run_test!
            end

            response '401', 'Invalid username or password' do
                let(:credentials) { { username: 'Test User', password: 'invalid' } }
                run_test!
            end
        end
    end

    path '/api/v1/register' do
        post 'Registers a new user' do
            tags 'Authentication'
            consumes 'application/json'
            parameter name: :user, in: :body, schema: {
                type: :object,
                properties: {
                    username: { type: :string },
                    email: { type: :string },
                    phone_number: { type: :string },
                    password: { type: :string }
                },
                required: ['username', 'email', 'phone_number', 'password']
            }

            response '201', 'user created' do
                let(:user) { { username: 'user1', email: 'user1@example.com', phone_number: '1234567890', password: 'password' } }
                run_test!
            end

            response '422', 'invalid request' do
                let(:user) { { username: 'user1' } }
                run_test!
            end
        end
    end

    path '/api/v1/me' do
        get 'Gets current user' do
            tags 'Authentication'
            produces 'application/json'
            security [bearer_auth: []]

            response '200', 'current user' do
                run_test!
            end
        end
    end

    path '/api/v1/users/{id}' do
        put 'Updates a user' do
            tags 'Users'
            consumes 'application/json'
            parameter name: :id, in: :path, type: :string
            parameter name: :user, in: :body, schema: {
                type: :object,
                properties: {
                    username: { type: :string },
                    email: { type: :string },
                    bio: { type: :string },
                    phone_number: { type: :string },
                    image: { type: :string }
                },
                required: ['username', 'email']
            }

            response '200', 'user updated' do
                let(:id) { User.create(username: 'user1', email: 'user1@example.com', phone_number: '1234567890', password: 'password').id }
                let(:user) { { username: 'new_user1', email: 'new_user1@example.com' } }
                run_test!
            end

            response '404', 'user not found' do
                let(:id) { 'invalid' }
                let(:user) { { username: 'new_user1', email: 'new_user1@example.com' } }
                run_test!
            end
        end

        delete 'Deletes a user' do
            tags 'Users'
            parameter name: :id, in: :path, type: :string

            response '200', 'user deleted' do
                let(:id) { User.create(username: 'user1', email: 'user1@example.com', phone_number: '1234567890', password: 'password').id }
                run_test!
            end

            response '404', 'user not found' do
                let(:id) { 'invalid' }
                run_test!
            end
        end
    end
end