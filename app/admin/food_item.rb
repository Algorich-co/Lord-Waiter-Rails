ActiveAdmin.register FoodItem do
  belongs_to :restaurant

  # menu :priority => 2
  permit_params :title, :price, :featured, :category_id, :restaurant_id, :image, :description

  scope :all, :default => true
  
  
  scope :featured_food_item do |food_item|
    food_item.where(:featured => true)
  end

  form do |f|
    f.inputs "FoodItem Details" do
      f.input :title
      f.input :description
      f.input :price
      f.input :featured
      f.input :category
      f.input :restaurant, :selected => f.restaurant.id
      f.input :image, :required => true, :as => :file
    end
    f.actions
  end

  show do |ad|
    attributes_table do
      row :thumbnail do
        image_tag(ad.image.url(:thumb))
      end
      row :title
      row :description
      row :price
      row :featured
      row :category
      row :restaurant
      
    # Will display the image on show object page
  end
end

  # index :as => :grid do |food_item|
  #   a truncate(food_item.title), :href => admin_food_item_path(food_item)
  # end
  index do
    id_column
    column :title
    column :price
    column :featured
    column :category
    column :restaurant
    actions
  end

  filter :title
  filter :price
  filter :featured
  filter :restaurant
  filter :category

  sidebar :food_item_stats, :only => :show do
    attributes_table_for resource do
      row("Total Sold")  { Order.find_with_food_item(resource).count }
      row("Value"){ number_to_currency LineItem.where(:food_item_id => resource.id).sum(:price), :locale => :pk }
    end
  end

  sidebar :recent_orders, :only => :show do
    Order.find_with_food_item(resource).limit(5).collect do |order|
      auto_link(order)
    end.join(content_tag("br")).html_safe
  end

  # sidebar "Active Admin Demo" do
  #   render('/admin/sidebar_links', :model => 'food_item')
  # end

end
