ActiveAdmin	.register RestaurantOwner do

	actions :index, :show, :edit, :update

	permit_params :full_name,:email, :contact, :image, :discount, :discount_available, :tax, :tax_available, :active, :locale


	index do
		selectable_column
		id_column
		column :full_name
		column :email
		column :contact
		column :tax_available
		column :active
		column :discount_available
		column :locale
		actions

	end

	form do |f|
		f.inputs "Owner Details" do
			f.input :full_name
			f.input :email
			f.input :contact
			f.input :image
			f.input :discount
			f.input :discount_available
			f.input :tax
			f.input :tax_available
			f.input :active
			f.input :locale
			f.input :password
			f.input :password_confirmation
		end
		f.actions
	end


	show do |ad|
		attributes_table do
			row :thumbnail do
				image_tag(ad.image.url(:thumb))
			end
			row :full_name
			row :email
			row :contact
			row :discount
			row :discount_available
			row :tax
			row :tax_available
			row :active
			row :locale
		end



		panel "Payments" do
			table_for(restaurant_owner.payments) do

				column :name do |cat|
					link_to("#{cat.name}", admin_restaurant_owner_payment_path(restaurant_owner, cat))
				end

				column :locale


				tr class: "action_items" do
					td link_to("New Payment", new_admin_restaurant_owner_payment_path(restaurant_owner),
						class: :button)
					end

				end
			end

			# panel "Subscription" do
			# 	table_for(restaurant_owner.subscription) do

			# 	column :Action do |cat|
			# 		link_to("SHOW", admin_restaurant_owner_subscription_path(restaurant_owner, cat))
			# 	end
			# 		column :number_of_branches 
			# 		column :number_of_managers 
			# 		column :managers_per_branch
			# 		column :valid_till


			# 		tr class: "action_items" do
			# 			td link_to("New Subscription", new_admin_restaurant_owner_subscription_path(restaurant_owner),
			# 				class: :button)
			# 			end

			# 		end
			# 	end

				

			end

			filter :full_name
			filter :email
			filter :contact
			filter :discount_available
			filter :discount
			filter :tax_available
			filter :tax
			filter :locale

		end
