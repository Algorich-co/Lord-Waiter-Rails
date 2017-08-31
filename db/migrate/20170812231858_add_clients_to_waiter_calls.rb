class AddClientsToWaiterCalls < ActiveRecord::Migration[5.0]
  def change
    add_reference :waiter_calls, :client, foreign_key: true
  end
end
