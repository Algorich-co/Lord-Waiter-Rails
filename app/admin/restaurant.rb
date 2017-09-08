ActiveAdmin.register Restaurant do

  permit_params :name,:active, :address, :contact, :image, :restaurant_owner

  
  index do
    selectable_column
    id_column
    column :name
    column :active
    column :contact
    column :restaurant_owner
    actions

  end

  form do |f|
    f.inputs "Restaurant Details" do
      f.input :name
      f.input :active
      f.input :address
      f.input :contact
      f.input :restaurant_owner
      f.input :image, :required => false, :as => :file
    end



    f.actions
  end

  show do |ad|
    attributes_table do
      row :thumbnail do
        image_tag(ad.image.url(:thumb))
      end
      row :name
      row :active
      row :address
      row :contact
      row :restaurant_owner
            
  end



  panel "Food Items" do
    table_for(restaurant.food_items) do

      column :title do |cat|
        link_to("#{cat.title}", admin_restaurant_food_item_path(restaurant, cat))
      end


      column :thumbnail do |cat|
        image_tag(cat.image.url(:thumb))
      end


      tr class: "action_items" do
        td link_to("New Item", new_admin_restaurant_food_item_path(restaurant),
         class: :button)
        end

      end
    end

    panel "Tables" do
      table_for(restaurant.tables) do

        column :name do |tab|
          link_to("#{tab.name}", admin_restaurant_table_path(restaurant, tab))
        end


        column :thumbnail do |tab|
          image_tag tab.qrcode.url(:medium), width: 100
        end


        tr class: "action_items" do
          td link_to("New Table", new_admin_restaurant_table_path(restaurant),
           class: :button)
          end

        end
      end

    end

    filter :name
    filter :active
    filter :address
    filter :contact
    filter :restaurant_owner

  end
