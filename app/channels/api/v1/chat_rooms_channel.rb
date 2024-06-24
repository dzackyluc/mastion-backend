module Api::V1
  class ChatRoomsChannel < ApplicationCable::Channel
    rescue_from 'Exception error', with: :deliver_error_message
  
    def subscribed
      stream_from "chat_rooms:#{params[:chat_room_id]}"
    end
  
    def unsubscribed
    end
  
    def send_message(data)
      ActionCable.server.broadcast("chat_rooms:#{params[:chat_room_id]}", { controls: data })
    end
  
    private
  
    def deliver_error_message
      ActionCable.server.broadcast("chat_rooms:#{params[:chat_room_id]}", { body: 'An error occurred' })
    end
  end
end