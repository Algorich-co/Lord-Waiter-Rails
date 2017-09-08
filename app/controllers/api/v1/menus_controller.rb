class Api::V1::MenusController < Api::V1::BaseController

  def menu
    client = Client.find_by(authentication_token: menu_params[:authentication_token])
    if !client.present?
      render json: {error: true, message: "Account not authorized, please login again." }, :status => 200
    elsif !Restaurant.find(menu_params[:restaurant_id]).restaurant_owner.active
      render json: {error: true, message: "Unfortunately, the restaurant is not functional online." }, :status => 200
    else
      @food_items = FoodItem.where(:restaurant_id => menu_params[:restaurant_id])
      @restaurant = Restaurant.find(menu_params[:restaurant_id])

      @json = {:restaurant => @restaurant.as_json(:only => [:id,:name,:address,:contact,:discount_available,:discount],:methods => [:image_url]), 
        :food_items => @food_items.as_json(:only => [:id,:title, :description, :price,:featured],:methods => [:image_url], :include => { :category => { :only => [:id, :name], :methods => :image_url }})}   

        render json: {error: false, message: "success", response: @json}

      end

    end


    private

    def menu_params
      params.permit(:authentication_token, :restaurant_id)
    end

  end