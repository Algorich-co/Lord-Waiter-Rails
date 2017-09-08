ActiveAdmin.register Subscription do

	# belongs_to :restaurant_owner

	permit_params :restaurant_owner_id, :number_of_branches, :number_of_managers, :managers_per_branch, :valid_till, :last_payment

	index do
		id_column
		column :restaurant_owner
		column :number_of_branches
		column :number_of_managers
		column :managers_per_branch
		column :valid_till
		column :last_payment
		actions
	end

	show do
		attributes_table do
			row :id
			row :restaurant_owner
			row :number_of_branches
			row :number_of_managers
			row :managers_per_branch
			row :valid_till
			row :last_payment
		end
	end

	form do |f|
		f.inputs "Subscription Details" do
			f.input :restaurant_owner
			f.input :number_of_branches
			f.input :number_of_managers
			f.input :managers_per_branch
			f.input :valid_till
			f.input :last_payment
		end
		f.actions
	end


	filter :restaurant_owner
	filter :number_of_branches
	filter :managers_per_branch
	filter :number_of_managers
	filter :valid_till
	filter :last_payment


end
