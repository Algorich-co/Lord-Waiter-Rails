class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery prepend: true, with: :exception

  helper_method :current_user

  def after_sign_in_path_for(resource)
    if resource.class == RestaurantManager
      restaurant_managers_index_path  
    elsif resource.class == RestaurantOwner
      restaurant_owners_index_path
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :restaurant_manager
      new_restaurant_manager_session_path
    elsif resource_or_scope == :restaurant_owner
      new_restaurant_owner_session_path
    else
      root_path
    end
  end
  

  private

  def current_user
    @current_user ||= RestaurantManager.find(session[:restaurant_manager_id]) if session[:restaurant_manager_id]
  end
end