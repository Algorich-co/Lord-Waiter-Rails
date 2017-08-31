class AddAttachmentQrcodeToTables < ActiveRecord::Migration
  def self.up
    change_table :tables do |t|
      t.attachment :qrcode
    end
  end

  def self.down
    remove_attachment :tables, :qrcode
  end
end
