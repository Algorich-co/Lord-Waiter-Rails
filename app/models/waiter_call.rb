class WaiterCall < ApplicationRecord
  belongs_to :table
  belongs_to :client
  validates_presence_of :table
  validates_presence_of :client
end
