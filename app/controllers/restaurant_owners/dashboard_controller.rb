class RestaurantOwners::DashboardController < ApplicationController
	layout 'restaurant_owners'
	before_action :authenticate_restaurant_owner!


	def index
	end

	def details
	end


end