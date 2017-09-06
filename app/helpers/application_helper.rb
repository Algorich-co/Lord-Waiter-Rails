module ApplicationHelper
	def show_errors(object, field_name)
		if object.errors.any?
			if !object.errors.messages[field_name].blank?
				object.errors.messages[field_name].join(", ")
			end
		end
	end 

	def error_class(object, field_name)
		if object.errors.any?
			if !object.errors.messages[field_name].blank?
				'invalid'
			end
		end
	end 

end
