module Api::V1
    class MastionVityChannel < ApplicationCable::Channel
      rescue_from 'Exception error', with: :deliver_error_message
    
      def subscribed
        stream_from "mastion_vity_channel:chat_rooms:#{params[:chat_room_id]}"
      end
    
      def unsubscribed
      end
    
      def send_message(data)
        data_with_method = data.merge("method" => "send_message")
        receive_message(data)
      end

      def receive_message(data)
        data_with_method = data.merge("method" => "receive_message")
        ActionCable.server.broadcast("mastion_vity_channel:chat_rooms:#{params[:chat_room_id]}", data_with_method)
      end
    
      private
    
      def deliver_error_message
        ActionCable.server.broadcast("mastion_vity_channel:chat_rooms:#{params[:chat_room_id]}", { body: 'An error occurred' })
      end
    end
  end