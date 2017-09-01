class Table < ApplicationRecord
  belongs_to :restaurant
  has_many :orders
  has_many :waiter_calls
  validates_presence_of :name
  has_attached_file :qrcode, styles: { medium: "500x500>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :qrcode, content_type: /\Aimage\/.*\z/
end
