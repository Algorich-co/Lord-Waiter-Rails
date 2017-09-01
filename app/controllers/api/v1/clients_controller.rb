class Api::V1::ClientsController < Api::V1::BaseController

  def show

    user = Client.find(params[:id])
    if authenticate_client(user)

      render json: {error: false, message: "success", response: Api::V1::ClientSerializer.new(user).as_json}

    else
      render json: {error: true, message: "Failed to fetch account" }, :status => 200
    end
    
  end

  def create
    @client = Client.new(client_params)
    @client.generate_authentication_token
    if @client.save
      response = Api::V1::SessionSerializer.new(@client).as_json
      render json: {error: false, message: "success", response: response}
    else
      acc = Client.find_by(email: client_params[:email])
      if !acc.present? || acc == nil
        render json: {error: true, message: "Failed to create account" }, :status => 200
      else
        render json: {error: true, message: "Account already exists." }, :status => 200
      end
    end
  end

  def set_gcm
    client = Client.find_by(authentication_token: set_gcm_params[:authentication_token])
    if !client.present? || client == nil
      render json: {error: true, message: "Account not authorized, please login again." }, :status => 200
    else
      client.gcm = set_gcm_params[:gcm]
      client.save!
      render json: {error: false, message: "success", response: Api::V1::ClientSerializer.new(client).as_json}
    end
  end

  def client_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def set_gcm_params
    params.permit(:authentication_token, :gcm)
  end

  def authenticate_client(user)
    client = Client.find_by(authentication_token: request.headers['Authorization'])
    if user == client
      return true
    else
      return false
    end    
  end


end