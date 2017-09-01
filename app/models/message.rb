class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :restaurant_manager
end
