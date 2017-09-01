class Api::V1::FacebookController < Api::V1::BaseController


  def create

    if Client.find_by(:email => client_params[:email]).nil?

      random_string = SecureRandom.hex
      
      @client = Client.new(:name => client_params[:name], :email => client_params[:email], :password => random_string, :password_confirmation => random_string)
      @client.facebook_id = client_params[:facebook_id]
      @client.facebook_token = client_params[:facebook_token]
      @client.connected_with_facebook = true
      @client.generate_authentication_token
      if @client.save
        render json: {error: false, message: "success", response: Api::V1::SessionSerializer.new(@client).as_json}
      else
        render json: {error: true, message: "Failed to create account" }, :status => 200
      end
      # Does not exist
      # Create new
    else
      @client = Client.find_by(:email => client_params[:email])
      @client.generate_authentication_token
      @client.save
      
      render json: {error: false, message: "success", response: Api::V1::SessionSerializer.new(@client).as_json}

    end    
  end

  def client_params
    params.permit(:facebook_id, :facebook_token, :name, :email)

  end

end