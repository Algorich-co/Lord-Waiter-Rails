class UsersController < ApplicationController
	before_action :authenticate_restaurant_manager!
end
