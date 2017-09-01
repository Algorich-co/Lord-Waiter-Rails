class Order < ApplicationRecord
	belongs_to :table
	belongs_to :restaurant
	belongs_to :client
	has_many :line_items, :dependent => :destroy

	scope :in_progress, ->{where("orders.preparing_at IS NOT NULL")}
	scope :complete, -> {where("orders.checked_out_at IS NOT NULL")}
	scope :served, -> {where("orders.served_at IS NOT NULL")}
	scope :in_queue, -> {where("orders.preparing_at IS NULL")}

	COMPLETE = "complete"
	SERVED = "served"
	IN_PROGRESS = "in_progress"
	IN_QUEUE = "in_queue"

	def self.find_with_food_item(food_item)
		return [] unless food_item
		complete.joins(:line_items).
		where(["line_items.food_item_id = ?", food_item.id]).
		order("orders.checked_out_at DESC")
	end

	def checkout!
		self.checked_out_at = Time.now
		self.save
	end

	def prepare!
		self.preparing_at = Time.now
		self.save
	end

	def serve!
		self.served_at = Time.now
		self.save
	end

	def recalculate_price!
		self.total_price = line_items.inject(0.0){|sum, line_item| sum += line_item.price }
		save!
	end

	def state
		if checked_out_at.nil?
			if served_at.nil?
				if preparing_at.nil?
					IN_QUEUE
				else
					IN_PROGRESS
				end
			else
				SERVED
			end
		else
			COMPLETE
		end
	end

	def display_name
		ActionController::Base.helpers.number_to_currency(total_price, locale: "pk") +
		" - Order ##{id} (#{table.name})"
	end

end
