ActiveAdmin.register Payment do

	belongs_to :restaurant_owner

	permit_params :restaurant_owner_id, :price, :locale

	index do
		id_column
		column :restaurant_owner
		column :price
		column :locale
		column :created_at
		actions
	end

	show do
		attributes_table do
			row :id
			row :restaurant_owner
			row :price
			row :locale
			row :created_at
		end
	end

	form do |f|
		f.inputs "New Payment" do
			f.input :restaurant_owner
			f.input :price
		end
		f.actions
	end


	filter :name
	filter :restaurant_owner
	filter :created_at
	filter :locale


end
