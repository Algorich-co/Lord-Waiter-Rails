ActiveAdmin.register Restaurant do

  permit_params :name,:active, :address, :contact, :image, :discount, :discount_available, :tax, :tax_available

  
  index do
    selectable_column
    id_column
    column :name
    column :active
    column :address
    column :contact
    column :tax_available
    column :discount_available
    actions

  end

  form do |f|
    f.inputs "Restaurant Details" do
      f.input :name
      f.input :active
      f.input :address
      f.input :contact
      f.input :image, :required => false, :as => :file
      f.input :discount
      f.input :discount_available
      f.input :tax
      f.input :tax_available

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
      row :discount
      row :discount_available
      row :tax
      row :tax_available
      
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
    filter :discount_available
    filter :discount
    filter :tax_available
    filter :tax

  end
