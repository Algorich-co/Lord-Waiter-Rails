ActiveAdmin.register Client do

permit_params :email, :name
  config.clear_action_items!

  index do
    selectable_column
    id_column
    column :email
    column :name
    # actions
  end

  filter :email
  filter :name

  show do |ad|
    attributes_table do
      row :email
      row :name
      
    end
  end

end
