class RestaurantOwners::RegistrationsController < Devise::RegistrationsController
  layout 'restaurant_owners_out'
  prepend_before_action :check_captcha, only: [:create, :update]
  # after_action :create_subscription, only: [:create]
  after_filter :create_subscription

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

  def create_subscription
    if resource.persisted? && resource.subscription.nil? # user is created successfuly
      resource.create_subscription
    end
  end


    
end