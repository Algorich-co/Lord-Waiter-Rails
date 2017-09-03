class RestaurantOwners::RegistrationsController < Devise::RegistrationsController
  layout 'restaurant_owners'
  prepend_before_action :check_captcha, only: [:create, :update]

  private

  def sign_up_params
    params.require(:restaurant_owner).permit(:email, :full_name, :contact, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:restaurant_owner).permit(:email, :full_name, :contact, :password, :password_confirmation, :current_password)
  end

  def check_captcha
      unless verify_recaptcha
        self.resource = resource_class.new sign_up_params
        resource.validate # Look for any other validation errors besides Recaptcha
        respond_with_navigational(resource) { render :new }
      end 
    end
    
end