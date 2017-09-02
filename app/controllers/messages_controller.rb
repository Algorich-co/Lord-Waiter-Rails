class MessagesController < ApplicationController
  before_action :authenticate_restaurant_manager!

  def create
    message = Message.new(message_params)
    message.restaurant_manager = current_restaurant_manager
    if message.save
      ActionCable.server.broadcast 'messages-1',
        message: message.content,
        restaurant_manager: message.restaurant_manager.email,
        type: "message"
      head :ok
    end
  end

  private

    def message_params
      params.require(:message).permit(:content, :chatroom_id)
    end
end
