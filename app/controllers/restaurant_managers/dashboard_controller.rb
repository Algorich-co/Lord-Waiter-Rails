class RestaurantManagers::DashboardController < ApplicationController
	layout 'restaurant_managers'
	before_action :authenticate_restaurant_manager!

	def index
		all_orders = current_restaurant_manager.restaurant.orders

		@in_queue = all_orders.select do |hash|
			hash.preparing_at.nil?
		end	

		@preparing = all_orders.select do |hash|
			!hash.preparing_at.nil? && hash.served_at.nil?
		end

		@serving = all_orders.select do |hash|
			!hash.served_at.nil? && hash.checked_out_at.nil?
		end

		table_ids = current_restaurant_manager.restaurant.tables.map{|table| table.id }
		@waiter_calls = WaiterCall.where(table_id: table_ids, complete: false)
	end

	def order_preparing
		order = Order.find(params[:order_id])
		
		order.prepare!

		ActionCable.server.broadcast "messages-#{order.restaurant.id}", 
		order_id: order.id, 
		order_state: order.state,
		message: 'Message from order preparing',
		user: 'controller',
		type: 'order'


		# n = Rpush::Gcm::Notification.new
		# n.app = Rpush::Gcm::App.find_by_name("lordwaiter")
		# client_id = order.client.gcm
		# n.registration_ids = [client_id]
		# n.data = { message: "khapa update!", order_id: order.id, order_state: order.state }
		# n.priority = 'high'        # Optional, can be either 'normal' or 'high'
		# n.content_available = true # Optional
		# n.notification = { body: 'Your order is being prepared!',
		# 	title: order.restaurant.name
		# }
		# n.save!

		head :ok

	end

	def order_serving
		order = Order.find(params[:order_id])
		order.serve!

		ActionCable.server.broadcast "messages-#{order.restaurant.id}", 
		order_id: order.id, 
		order_state: order.state,
		message: 'Message from order serving',
		user: 'controller',
		type: 'order'


		# n = Rpush::Gcm::Notification.new
		# n.app = Rpush::Gcm::App.find_by_name("lordwaiter")
		# client_id = order.client.gcm
		# n.registration_ids = [client_id]
		# n.data = { message: "khapa update!", order_id: order.id, order_state: order.state }
		# n.priority = 'high'        # Optional, can be either 'normal' or 'high'
		# n.content_available = true # Optional
		# n.notification = { body: 'Your order is prepared!',
		# 	title: order.restaurant.name
		# }
		# n.save!

		head :ok

	end

	def order_checkout
		order = Order.find(params[:order_id])
		order.checkout!

		ActionCable.server.broadcast "messages-#{order.restaurant.id}", 
		order_id: order.id, 
		order_state: order.state,
		message: 'Message from order checkout',
		user: 'controller',
		type: 'order'


		# n = Rpush::Gcm::Notification.new
		# n.app = Rpush::Gcm::App.find_by_name("lordwaiter")
		# client_id = order.client.gcm
		# n.registration_ids = [client_id]
		# n.data = { message: "khapa update!", order_id: order.id, order_state: order.state }
		# n.priority = 'high'        # Optional, can be either 'normal' or 'high'
		# n.content_available = true # Optional
		# n.notification = { body: 'Thank you for dining with us.',
		# 	title: order.restaurant.name
		# }
		# n.save!

		head :ok

	end

	def receive_waiter_call
		waiter_call = WaiterCall.find(params[:waiter_call_id])
		waiter_call.complete = true
		waiter_call.save!

		ActionCable.server.broadcast "messages-#{waiter_call.table.restaurant.id}", 
		waiter_call_id: waiter_call.id, 
		waiter_call_complete: waiter_call.complete,
		message: 'Message from order serving',
		user: 'controller',
		type: 'waiter_call'


		# n = Rpush::Gcm::Notification.new
		# n.app = Rpush::Gcm::App.find_by_name("lordwaiter")
		# client_id = waiter_call.client.gcm
		# n.registration_ids = [client_id]
		# n.data = { message: "khapa update!" }
		# n.priority = 'high'        # Optional, can be either 'normal' or 'high'
		# n.content_available = true # Optional
		# n.notification = { body: 'We are sending you a waiter in a minute',
		# 	title: waiter_call.table.restaurant.name
		# }
		# n.save!

		head :ok		
	end

end