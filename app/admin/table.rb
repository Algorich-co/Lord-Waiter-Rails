ActiveAdmin.register Table do
	belongs_to :restaurant

	permit_params :restaurant_id, :name

	after_create do |table|
		qr = RQRCode::QRCode.new("lordwaiter restaurant:#{table.restaurant_id};table:#{table.id}")
		png = qr.as_png(
			resize_gte_to: false,
			resize_exactly_to: false,
			fill: 'white',
			color: 'black',
			size: 500,
			border_modules: 4,
			module_px_size: 6,
          file: "app/assets/images/qrCodes/restaurant:#{table.restaurant_id};table:#{table.id}.png" # path to write
          )
		table.qrcode = File.open("app/assets/images/qrCodes/restaurant:#{table.restaurant_id};table:#{table.id}.png")
		table.save!
	end

	index do
		id_column
		column :restaurant
		column :name
		actions
	end

	show do
		attributes_table do
			row :id
			row :qrcode do |table|
				if table.qrcode
					image_tag table.qrcode.url(:medium), width: 400
				end
			end
			row :restaurant
			row :name
		end
	end

	form do |f|
		f.inputs "New Table" do
			f.input :restaurant
			f.input :name
		end
		f.actions
	end


	filter :name
	filter :restaurant

end