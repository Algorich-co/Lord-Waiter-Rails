# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170904164237) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "chatrooms", force: :cascade do |t|
    t.string   "topic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  create_table "clients", force: :cascade do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "name"
    t.string   "belongs_to"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "authentication_token",    default: ""
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "connected_with_facebook", default: false
    t.string   "facebook_id"
    t.text     "facebook_token"
    t.text     "gcm"
    t.index ["authentication_token"], name: "index_clients_on_authentication_token", unique: true, using: :btree
  end

  create_table "food_items", force: :cascade do |t|
    t.string   "title"
    t.decimal  "price"
    t.boolean  "featured",           default: false
    t.integer  "category_id"
    t.integer  "restaurant_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "description",        default: ""
    t.index ["category_id"], name: "index_food_items_on_category_id", using: :btree
    t.index ["restaurant_id"], name: "index_food_items_on_restaurant_id", using: :btree
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "food_item_id"
    t.decimal  "price"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["food_item_id"], name: "index_line_items_on_food_item_id", using: :btree
    t.index ["order_id"], name: "index_line_items_on_order_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.string   "content"
    t.integer  "restaurant_manager_id"
    t.integer  "chatroom_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id", using: :btree
    t.index ["restaurant_manager_id"], name: "index_messages_on_restaurant_manager_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "table_id"
    t.integer  "restaurant_id"
    t.boolean  "delivered"
    t.boolean  "paid"
    t.decimal  "total_price",    precision: 8, scale: 2, default: "0.0"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.datetime "checked_out_at"
    t.integer  "client_id"
    t.datetime "preparing_at"
    t.datetime "served_at"
    t.index ["client_id"], name: "index_orders_on_client_id", using: :btree
    t.index ["restaurant_id"], name: "index_orders_on_restaurant_id", using: :btree
    t.index ["table_id"], name: "index_orders_on_table_id", using: :btree
  end

  create_table "restaurant_managers", force: :cascade do |t|
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "name"
    t.integer  "restaurant_id"
    t.string   "unique_session_id",      limit: 20
    t.index ["email"], name: "index_restaurant_managers_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_restaurant_managers_on_reset_password_token", unique: true, using: :btree
    t.index ["restaurant_id"], name: "index_restaurant_managers_on_restaurant_id", using: :btree
  end

  create_table "restaurant_owners", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "full_name"
    t.string   "contact"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.decimal  "tax",                    default: "0.0"
    t.boolean  "tax_available",          default: false
    t.decimal  "discount",               default: "0.0"
    t.boolean  "discount_available",     default: false
    t.index ["confirmation_token"], name: "index_restaurant_owners_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_restaurant_owners_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_restaurant_owners_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_restaurant_owners_on_unlock_token", unique: true, using: :btree
  end

  create_table "restaurants", force: :cascade do |t|
    t.string   "name"
    t.text     "address"
    t.string   "contact"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "active",              default: false
    t.integer  "restaurant_owner_id"
    t.index ["restaurant_owner_id"], name: "index_restaurants_on_restaurant_owner_id", using: :btree
  end

  create_table "rpush_apps", force: :cascade do |t|
    t.string   "name",                                null: false
    t.string   "environment"
    t.text     "certificate"
    t.string   "password"
    t.integer  "connections",             default: 1, null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "type",                                null: false
    t.string   "auth_key"
    t.string   "client_id"
    t.string   "client_secret"
    t.string   "access_token"
    t.datetime "access_token_expiration"
  end

  create_table "rpush_feedback", force: :cascade do |t|
    t.string   "device_token", limit: 64, null: false
    t.datetime "failed_at",               null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "app_id"
    t.index ["device_token"], name: "index_rpush_feedback_on_device_token", using: :btree
  end

  create_table "rpush_notifications", force: :cascade do |t|
    t.integer  "badge"
    t.string   "device_token",      limit: 64
    t.string   "sound",                        default: "default"
    t.text     "alert"
    t.text     "data"
    t.integer  "expiry",                       default: 86400
    t.boolean  "delivered",                    default: false,     null: false
    t.datetime "delivered_at"
    t.boolean  "failed",                       default: false,     null: false
    t.datetime "failed_at"
    t.integer  "error_code"
    t.text     "error_description"
    t.datetime "deliver_after"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.boolean  "alert_is_json",                default: false
    t.string   "type",                                             null: false
    t.string   "collapse_key"
    t.boolean  "delay_while_idle",             default: false,     null: false
    t.text     "registration_ids"
    t.integer  "app_id",                                           null: false
    t.integer  "retries",                      default: 0
    t.string   "uri"
    t.datetime "fail_after"
    t.boolean  "processing",                   default: false,     null: false
    t.integer  "priority"
    t.text     "url_args"
    t.string   "category"
    t.boolean  "content_available",            default: false
    t.text     "notification"
    t.index ["delivered", "failed"], name: "index_rpush_notifications_multi", where: "((NOT delivered) AND (NOT failed))", using: :btree
  end

  create_table "tables", force: :cascade do |t|
    t.string   "qr"
    t.integer  "restaurant_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "name"
    t.string   "qrcode_file_name"
    t.string   "qrcode_content_type"
    t.integer  "qrcode_file_size"
    t.datetime "qrcode_updated_at"
    t.index ["restaurant_id"], name: "index_tables_on_restaurant_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "waiter_calls", force: :cascade do |t|
    t.integer  "table_id"
    t.boolean  "complete",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "client_id"
    t.index ["client_id"], name: "index_waiter_calls_on_client_id", using: :btree
    t.index ["table_id"], name: "index_waiter_calls_on_table_id", using: :btree
  end

  add_foreign_key "food_items", "categories"
  add_foreign_key "food_items", "restaurants"
  add_foreign_key "line_items", "food_items"
  add_foreign_key "line_items", "orders"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "restaurant_managers"
  add_foreign_key "orders", "clients"
  add_foreign_key "orders", "restaurants"
  add_foreign_key "orders", "tables"
  add_foreign_key "restaurant_managers", "restaurants"
  add_foreign_key "restaurants", "restaurant_owners"
  add_foreign_key "tables", "restaurants"
  add_foreign_key "waiter_calls", "clients"
  add_foreign_key "waiter_calls", "tables"
end
