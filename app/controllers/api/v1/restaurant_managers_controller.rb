class Api::V1::RestaurantManagersController < Api::V1::BaseController

	def set_manager_gcm
		restaurantManager = RestaurantManager.find(managers_params[:restaurant_manager])
		if !restaurantManager.present? || restaurantManager == nil
			render json: {error: true, message: "Account not found." }, :status => 200
		else
			restaurantManager.gcm = managers_params[:gcm]
			restaurantManager.save!
			render json: {error: false, message: "success"}
		end
	end


	private

	def managers_params
		params.permit(:restaurant_manager, :gcm)
	end

end