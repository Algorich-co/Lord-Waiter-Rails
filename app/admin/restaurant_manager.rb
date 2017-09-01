ActiveAdmin.register RestaurantManager do

	permit_params :name, :email, :restaurant_id, :password, :password_confirmation

	index do
		id_column
		column :name
		column :email
		column :restaurant
		actions
	end

	form do |f|
		f.inputs "Manager Details" do
			f.input :name
			f.input :email
			f.input :restaurant
			f.input :password
			f.input :password_confirmation
		end
		f.actions
	end

	show do |ad|
		attributes_table do
			row :name
			row :email
			row :restaurant
			row :created_at
			row :updated_at			
		end
	end

	filter :name
	filter :email
	filter :restaurant

end
