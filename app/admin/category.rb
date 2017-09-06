ActiveAdmin.register Category do

  permit_params :name, :image


  index do
    id_column
    column :name
    actions
  end

  filter :name

  form do |f|
    f.inputs "Category Details" do
      f.input :name
      f.input :image, :required => true, :as => :file
    end
    f.actions
  end

  show do |ad|
    attributes_table do
      row :name
      row :thumbnail do
        image_tag(ad.image.url(:thumb))
      end
      # Will display the image on show object page
    end

    panel "Food Item" do
      table_for(category.food_items) do

        column :title do |food|
          link_to("#{food.title}", admin_category_food_item_path(category, food))
        end


        column :thumbnail do |food|
          image_tag(food.image.url(:thumb))
        end


        tr class: "action_items" do
          td link_to("New Food Item", new_admin_category_food_item_path(category),
           class: :button)
          end
        end
      end

    end

  end
