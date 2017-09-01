class RestaurantManager < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable,:validatable, registerable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable

  belongs_to :restaurant
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :restaurant

end
