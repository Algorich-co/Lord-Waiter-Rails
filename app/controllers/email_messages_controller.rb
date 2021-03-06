class EmailMessagesController < ApplicationController
	layout 'email_messages'
	def new
		@message = EmailMessage.new
	end

	def create
		@message = EmailMessage.new message_params

		if verify_recaptcha(model: @message) && @message.valid?
			MessageMailer.send_message_confirmation(@message).deliver_now
			MessageMailer.send_message_to_admin(@message).deliver_now
			redirect_to new_email_message_url, notice: "Message received, thanks!"
		else
			render :new
		end
	end

	private

	def message_params
		params.require(:email_message).permit(:name, :email, :body)
	end
end
