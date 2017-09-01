class Api::V1::BaseController < ApplicationController

  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, with: :not_found!


  before_action :destroy_session

  def destroy_session
    request.session_options[:skip] = true
  end

  def not_found
    return api_error(status: 404, errors: 'Not found')
  end

  def authenticate_user!
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

    user_email = options.blank?? nil : options[:email]
    client = user_email && Client.find_by(email: user_email)

    if client && ActiveSupport::SecurityUtils.secure_compare(client.authentication_token, token)
      @current_user = client
    else
      return unauthenticated!
    end
  end
  
end