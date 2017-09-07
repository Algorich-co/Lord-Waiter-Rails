class RestaurantOwners::TablesController < ApplicationController
	layout 'restaurant_owners'
	before_action :set_table, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_restaurant_owner!
	after_action :create_qr, only: [:create]


	def index
		@tables = current_restaurant_owner.tables
	end

	def new
		@table = current_restaurant_owner.tables.build
	end

	def create
		@table = current_restaurant_owner.tables.build(table_params)
		if @table.save
			flash[:success] = "Your Table has been created!"
			redirect_to restaurant_owners_tables_path
		else
			flash.now[:alert] = "Your new Table couldn't be created!  Please check the form."
			render :new
			# redirect_to new_restaurant_owners_restaurant_path(restaurant: params[:restaurant])
		end
	end

	def show
	end

	def edit
		
	end

	def update
		if @table.update(table_params)
			flash[:success] = "Table updated."
			redirect_to restaurant_owners_tables_path
		else
			flash.now[:alert] = "Update failed.  Please check the form."
			render :edit
		end
	end

	def destroy
		@table.destroy
		redirect_to restaurant_owners_tables_path
	end

	private

	def table_params
		params.require(:table).permit(:name, :restaurant_id)
	end

	def set_table
		id_to_match = Table.find(params[:id]).restaurant.id
		if current_restaurant_owner.restaurants.map{|a| a.id}.include? id_to_match
			@table = Table.find(params[:id])
		else
			redirect_to restaurant_owners_tables_path
		end		
	end

	def create_qr
		qr = RQRCode::QRCode.new("lordwaiter restaurant:#{@table.restaurant_id};table:#{@table.id}")
		png = qr.as_png(
			resize_gte_to: false,
			resize_exactly_to: false,
			fill: 'white',
			color: 'black',
			size: 500,
			border_modules: 4,
			module_px_size: 6,
			file: "tmp/restaurant:#{@table.restaurant_id};table:#{@table.id}.png"
          )

		@table.qrcode = File.open("tmp/restaurant:#{@table.restaurant_id};table:#{@table.id}.png")
		@table.save!	
	end


end