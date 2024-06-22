class ApplicationController < ActionController::API
    before_action :authorized

    def encode_token(payload)
        JWT.encode(payload, '#mastion2024', 'HS256')
    end

    def decoded_token
        headers = request.headers['Authorization']
        if headers
            token = headers.split(' ')[1]
            begin
                JWT.decode(token, '#mastion2024', true, algorithm: 'HS256')
            rescue JWT::DecodeError
                nil
            end
        end
    end

    def session_user
        decoded_hash = decoded_token
        if decoded_hash
            user_id = decoded_hash[0]['user_id']
            @user = User.find_by(id: user_id)
        end
    end

    def authorized
        unless !!session_user
            render json: { message: 'Please log in' }, status: :unauthorized
        end
    end
end
