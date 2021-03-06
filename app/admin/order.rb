ActiveAdmin.register Order do

  # menu :priority => 3
  actions :index, :show

  filter :total_price
  filter :checked_out_at

  scope :all, :default => true
  scope :in_progress
  scope :complete

  index do
  	column("Order", :sortable => :id) {|order| link_to "##{order.id} ", admin_order_path(order) }
  	column("State")                   {|order| status_tag(order.state) }
  	column("Date", :checked_out_at)
  	column :restaurant
  	column :table
  	column("Total")                   {|order| number_to_currency order.total_price, :locale => :pk }
  end



  show do
  	attributes_table do
  		row :restaurant
  		row :table 
  		row :state
  		row :delivered
  		row :paid
  		row :total_price
  	end

  	panel "Invoice" do

  		table_for(order.line_items) do |t|
  			t.column("Food Item") {|item| auto_link item.food_item        }
  			t.column("Price")   {|item| number_to_currency item.price, :locale => :pk }
  			tr :class => "odd" do
  				td "Total:", :style => "text-align: right;"
  				td number_to_currency(order.total_price, :locale => :pk)
  			end
  		end
  	end
  end

  sidebar :restaurant_information, :only => :show do
  	attributes_table_for order.restaurant do
  		row("Restaurant") { auto_link order.restaurant }
  		row :name
  		row :contact
  	end
  end

  sidebar :table_information, :only => :show do
  	attributes_table_for order.table do
  		row("Table") { auto_link order.table }
  		row :name
  	end
  end

  # sidebar "Active Admin Demo" do
  #   render('/admin/sidebar_links', :model => 'orders')
  # end

end
