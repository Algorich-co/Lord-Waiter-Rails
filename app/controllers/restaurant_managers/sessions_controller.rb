class RestaurantManagers::SessionsController < Devise::SessionsController
  layout 'restaurant_managers'
  prepend_before_action :check_captcha, only: [:create] # Change this to be any actions you want to protect.

  private
    def check_captcha
      unless verify_recaptcha
        if defined? sign_up_params
          self.resource = resource_class.new sign_up_params
          resource.validate # Look for any other validation errors besides Recaptcha
          respond_with_navigational(resource) { render :new }
        elsif defined? sign_in_params
          self.resource = resource_class.new sign_in_params
          resource.validate # Look for any other validation errors besides Recaptcha
          respond_with_navigational(resource) { render :new }
        end 
      end 
    end
end