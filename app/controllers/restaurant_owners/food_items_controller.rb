class RestaurantOwners::FoodItemsController < ApplicationController
	layout 'restaurant_owners'
	before_action :set_food_item, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_restaurant_owner!


	def index
		@food_items = current_restaurant_owner.food_items
	end

	def new
		@food_item = current_restaurant_owner.food_items.build
	end

	def create
		@food_item = current_restaurant_owner.food_items.build(food_item_params)
		if @food_item.save
			flash[:success] = "Your Product has been created!"
			redirect_to restaurant_owners_food_items_path
		else
			flash.now[:alert] = "Your new product couldn't be created!  Please check the form."
			render :new
			# redirect_to new_restaurant_owners_restaurant_path(restaurant: params[:restaurant])
		end
	end

	def show
	end

	def edit
		
	end

	def update
		if @food_item.update(food_item_params)
			flash[:success] = "Product updated."
			redirect_to restaurant_owners_food_items_path
		else
			flash.now[:alert] = "Update failed.  Please check the form."
			render :edit
		end
	end

	def destroy
		@food_item.destroy
		redirect_to restaurant_owners_food_items_path
	end

	private

	def food_item_params
		params.require(:food_item).permit(:title, :price, :featured,:restaurant_id, :category_id, :image)
	end

	def set_food_item
		id_to_match = FoodItem.find(params[:id]).restaurant.id
		if current_restaurant_owner.restaurants.map{|a| a.id}.include? id_to_match
			@food_item = FoodItem.find(params[:id])
		else
			redirect_to restaurant_owners_food_items_path
		end		
	end


end