class MessagesChannel < ApplicationCable::Channel  
  def subscribed
    stream_from "messages-#{params['restaurant_id']}"
  end
end  
