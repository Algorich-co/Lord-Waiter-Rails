class MessageMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.message_mailer.send_message_confirmation.subject
  #
  def send_message_confirmation(message)
    @body = message.body
    mail to: message.email, subject: "Message Received", from: "noreply@lordwaiter.com"
  end

  def send_message_to_admin(message)
    @body = message.body
    @email = message.email
    @name = message.name
    mail to: "support@lordwaiter.com", subject: "Message Received", from: "noreply@lordwaiter.com"
  end
end