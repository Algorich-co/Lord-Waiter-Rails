class ClientsController < ApplicationController
	def new
		@client = Client.new
	end

	def create
		@client = Client.new(client_params)
		if @client.save
			redirect_to root_url, :notice => "Signed up!"
		else
			render "new"
		end
	end

	def client_params
		# params.require(:client).permit(:email, :password_hash, :password_salt, :password, :password_confirmation)
		params.require(:client).permit(:name, :email, :password, :password_confirmation)

	end

end