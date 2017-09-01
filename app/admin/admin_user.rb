ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation
  config.clear_action_items!

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    # actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  show do |ad|
    attributes_table do
      row :email
      row :created_at
      row :updated_at
      row :sign_in_count
      row :current_sign_in_at

      
    end
  end

end
