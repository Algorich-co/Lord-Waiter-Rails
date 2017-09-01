class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :authenticate_user!
  # helper_method :current_user, :logged_in?

  # def current_user
  #   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  # end

  # def logged_in?
  #   !!current_user
  # end

  def after_sign_in_path_for(resource)
    if resource.class == RestaurantManager
      restaurant_managers_index_path  
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :restaurant_manager
      new_restaurant_manager_session_path
    else
      root_path
    end
  end
  

  # private

  # def current_user
  #   @current_user ||= RestaurantManager.find(session[:restaurant_manager_id]) if session[:restaurant_manager_id]
  # end


  # protected

  # def authenticate_user!
  #   redirect_to root_path unless logged_in?
  # end
end
