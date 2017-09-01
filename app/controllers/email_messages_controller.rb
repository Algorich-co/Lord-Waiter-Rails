class EmailMessagesController < ApplicationController
	def new
		@message = Message.new
	end

	def create
		@message = Message.new message_params

		if @message.valid?
			MessageMailer.send_message_confirmation(@message).deliver_now
			MessageMailer.send_message_to_admin(@message).deliver_now
			redirect_to new_message_url, notice: "Message received, thanks!"
		else
			render :new
		end
	end

	private

	def message_params
		params.require(:message).permit(:name, :email, :body)
	end
end
