class RestaurantOwners::RestaurantsController < ApplicationController
	layout 'restaurant_owners'
	before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_restaurant_owner!


	def index
		@restaurants = current_restaurant_owner.restaurants
	end

	def new
		@restaurant = current_restaurant_owner.restaurants.build
	end

	def create
		@restaurant = current_restaurant_owner.restaurants.build(restaurant_params)
		if @restaurant.save
			flash[:success] = "Your branch has been created!"
			redirect_to restaurant_owners_restaurant_owners_index_path
		else
			flash.now[:alert] = "Your new branch couldn't be created!  Please check the form."
			render :new
			# redirect_to new_restaurant_owners_restaurant_path(restaurant: params[:restaurant])
		end
	end

	def show
	end

	def edit
		
	end

	def update
		if @restaurant.update(post_params)
			flash[:success] = "Branch updated."
			redirect_to restaurant_owners_restaurant_owners_index_path
		else
			flash.now[:alert] = "Update failed.  Please check the form."
			render :edit
		end
	end

	def destroy
		@restaurant.destroy
		redirect_to restaurant_owners_restaurant_owners_index_path
	end

	private

	def restaurant_params
		params.require(:restaurant).permit(:name, :image, :contact, :address)
	end

	def set_restaurant
		if Restaurant.find(params[:id]).restaurant_owner.id == current_restaurant_owner.id	
			@restaurant = Restaurant.find(params[:id])
		else
			redirect_to restaurant_owners_restaurant_owners_index_path
		end		
	end


end