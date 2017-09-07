require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LordWaiter
	class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
	    config.action_view.field_error_proc = Proc.new { |html_tag, instance| 
	    	if html_tag =~ /<(input|label|textarea|select)/
	    		html_field = Nokogiri::HTML::DocumentFragment.parse(html_tag)
	    		# html_field.first_element_child['class'] = 'invalid'
	    		# html_field.first_element_child['data-error']  = 'Error Agaya hai BC!'
	    		html_field.to_s.html_safe
	    	else
	    		html_tag
	    	end
	    }

	end
end
