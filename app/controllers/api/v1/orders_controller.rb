class Api::V1::OrdersController < Api::V1::BaseController
  skip_before_action  :verify_authenticity_token

  def create

    client = Client.find_by(authentication_token: create_params[:authentication_token])
    if !client.present? || client == nil
      render json: {error: true, message: "Account not authorized, please login again." }, :status => 200

    else
      # client.generate_authentication_token
      table = Table.find(create_params[:table_id])
      restaurant = Restaurant.find(create_params[:restaurant_id])
      order = table.orders.create!
      order.restaurant= restaurant
      order.client = client
      fi_items_ids = create_params[:food_item_ids].split(',')
      fi_item_quantities = create_params[:food_item_quantities].split(',')

      fi_items_ids.each_with_index do |val, index|
        food_item = FoodItem.find(val.to_i)
        food_item_quantity = fi_item_quantities[index]

        food_item_quantity.to_i.times do 
          LineItem.create! do |l|
            l.order = order
            l.food_item = food_item
            l.price = food_item.price
          end
        end        
      end

      order.recalculate_price!

      template = render_order_template(order)      
      
      ActionCable.server.broadcast "messages-#{order.restaurant.id}", 
        order_id: order.id, 
        order_state: order.state, 
        template: template,
        type: 'order'


      render json: {error: false, message: "success", response: Api::V1::OrderSerializer.new(order).as_json}

    end
    
  end


  def waiter_call_action
    client = Client.find_by(authentication_token: waiter_call_params[:authentication_token])
    if !client.present? || client == nil
      render json: {error: true, message: "Account not authorized, please login again." }, :status => 200
    else
      waiter_call = WaiterCall.create(table_id: waiter_call_params[:table_id], client_id: client.id)
      
      template = render_waiter_template(waiter_call)

      ActionCable.server.broadcast "messages-#{waiter_call.table.restaurant.id}", 
        waiter_call_id: waiter_call.id, 
        waiter_call_complete: waiter_call.complete, 
        template: template,
        type: 'waiter_call'


      render json: {error: false, message: "success"}
    end  

  end

  def set_manager_gcm
    client = RestaurantManager.find(set_gcm_params[:restaurant_manager_id])
    if !client.present? || client == nil
      render json: {error: true, message: "Account not found." }, :status => 200
    else
      client.gcm = set_gcm_params[:gcm]
      client.save!
      render json: {error: false, message: "success" }
    end
  end

  private

  def create_params
    params.permit(:authentication_token, :restaurant_id, :table_id, :food_item_ids, :food_item_quantities)
  end


  def waiter_call_params
    params.permit(:authentication_token, :table_id)
  end

  def set_gcm_params
    params.permit(:restaurant_manager_id, :gcm)
  end

  def render_waiter_template(waiter_call)
    HomeController.render(partial: 'restaurant_managers/waiter_calls', locals: { waiter_call: waiter_call }) 
  end

  def render_order_template(order)
    HomeController.render(partial: 'restaurant_managers/inqueue_item', locals: { order: order }) 
  end

end