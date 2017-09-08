class RestaurantOwners::RestaurantManagersController < ApplicationController
	layout 'restaurant_owners'
	before_action :set_restaurant_manager, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_restaurant_owner!


	def index
		@restaurant_managers = current_restaurant_owner.restaurant_managers
	end

	def new
		@restaurant_manager = current_restaurant_owner.restaurant_managers.build
	end

	def create
		@restaurant_manager = current_restaurant_owner.restaurant_managers.build(restaurant_manager_params)
		restaurant = Restaurant.find(@restaurant_manager.restaurant.id)
		if restaurant.restaurant_manager != nil
			flash.now[:alert] = "You can not create more than one manager for any branch."
			render :new
		elsif @restaurant_manager.save
			flash[:success] = "Your manager has been created!"
			redirect_to restaurant_owners_restaurant_managers_path		
		else
			flash.now[:alert] = "Your new manager couldn't be created!  Please check the form."
			render :new
			# redirect_to new_restaurant_owners_restaurant_path(restaurant: params[:restaurant])
		end
	end

	def show
	end

	def edit
		
	end

	def update
		if @restaurant_manager.update(restaurant_manager_params)
			flash[:success] = "Manager updated."
			redirect_to restaurant_owners_restaurant_managers_path
		else
			flash.now[:alert] = "Update failed.  Please check the form."
			render :edit
		end
	end

	def destroy
		@restaurant_manager.destroy
		redirect_to restaurant_owners_restaurant_managers_path
	end

	private

	def restaurant_manager_params
		params.require(:restaurant_manager).permit(:name, :email, :password,:password_confirmation, :restaurant_id)
	end

	def set_restaurant_manager
		id_to_match = RestaurantManager.find(params[:id]).restaurant.id
		if current_restaurant_owner.restaurants.map{|a| a.id}.include? id_to_match
			@restaurant_manager = RestaurantManager.find(params[:id])
		else
			redirect_to restaurant_owners_restaurant_managers_path
		end		
	end


end