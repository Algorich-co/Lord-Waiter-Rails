class RestaurantOwners::OrdersController < ApplicationController
	layout 'restaurant_owners'
	before_action :authenticate_restaurant_owner!
	before_action :set_order, only: [:show]

	def index
		@orders = current_restaurant_owner.orders
	end

	def show
	end

	private

	def set_order
		id_to_match = Order.find(params[:id]).restaurant.id
		if current_restaurant_owner.restaurants.map{|a| a.id}.include? id_to_match
			@order = Order.find(params[:id])
		else
			redirect_to restaurant_owners_orders_path
		end		
	end

end