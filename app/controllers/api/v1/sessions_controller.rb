class Api::V1::SessionsController < Api::V1::BaseController

  def create

    client = Client.authenticate(create_params[:email], create_params[:password])
    if !client.present?
      render json: {error: true, message: "Account not authorized, please login again." }, :status => 200
    else
      client.generate_authentication_token
      client.save
      render json: {error: false, message: "success", response: Api::V1::SessionSerializer.new(client).as_json}
    end

  end

  def destroy
    client = Client.find_by(authentication_token: destroy_params[:authentication_token])
    if !client.present?
      render json: {error: true, message: "Account not authorized, please login again." }, :status => 200
    else
      client.generate_authentication_token
      client.save
      render json: {error: false, message: "success"}
    end
  end

  private
  def create_params
    params.permit(:email, :password)
  end

  def destroy_params
    params.permit(:authentication_token)
  end

end