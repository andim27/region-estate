# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130123103907) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "cards", :force => true do |t|
    t.text     "text_white"
    t.text     "text_draft"
    t.integer  "info_source_id"
    t.string   "card_url",       :limit => 200
    t.integer  "have_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "cities", :force => true do |t|
    t.string "name",     :limit => 80
    t.string "name_rus", :limit => 80, :null => false
    t.string "country",  :limit => 80
  end

  create_table "contacts", :force => true do |t|
    t.string  "name",           :limit => 80,  :null => false
    t.string  "tel_mob_1",      :limit => 80,  :null => false
    t.string  "tel_mob_2",      :limit => 80,  :null => false
    t.string  "tel_mob_3",      :limit => 80,  :null => false
    t.string  "tel_city",       :limit => 80,  :null => false
    t.string  "address",        :limit => 80,  :null => false
    t.string  "email",          :limit => 80,  :null => false
    t.integer "have_id"
    t.integer "info_source_id"
    t.string  "dop",            :limit => 200, :null => false
    t.text    "attrib_list",                   :null => false
  end

  create_table "dop_params", :force => true do |t|
    t.integer  "parent"
    t.string   "name"
    t.text     "fields_list"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "have_fields", :force => true do |t|
    t.string "name"
    t.string "field_name"
    t.string "field_type"
    t.string "field_ui_type"
    t.string "field_ds"
    t.text   "field_list",    :null => false
  end

  create_table "haves", :force => true do |t|
    t.integer  "obj_id"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.integer  "rayon_id"
    t.integer  "rayons_admin_id"
    t.integer  "street_id"
    t.integer  "state_id"
    t.integer  "card_id"
    t.string   "orientir",        :limit => 80
    t.string   "house_n",         :limit => 10
    t.integer  "flat_n"
    t.string   "tel_1",           :limit => 80
    t.integer  "price_want",      :limit => 8,  :default => 0
    t.integer  "price_estimate",  :limit => 8,  :default => 0
    t.integer  "kurs_id",                       :default => 2, :null => false
    t.integer  "torg"
    t.text     "dop"
    t.integer  "room",            :limit => 2,                 :null => false
    t.integer  "s_all"
    t.integer  "s_live"
    t.integer  "s_kux"
    t.integer  "floor",           :limit => 2
    t.integer  "floor_house",     :limit => 2
    t.string   "year",            :limit => 10
    t.string   "ext_n",           :limit => 80
    t.integer  "sell_want",       :limit => 1,  :default => 0, :null => false
    t.integer  "obmen_want",      :limit => 1,  :default => 0, :null => false
    t.integer  "rent_want",       :limit => 2,  :default => 0, :null => false
    t.integer  "parent"
    t.integer  "zayavka_id"
    t.integer  "top_variant_id"
    t.integer  "variant",         :limit => 2,  :default => 1, :null => false
    t.integer  "variant_cnt",     :limit => 1,  :default => 1, :null => false
    t.boolean  "published"
  end

  add_index "haves", ["card_id"], :name => "card_id"
  add_index "haves", ["obj_id"], :name => "obj_id"
  add_index "haves", ["obj_id"], :name => "obj_id_2"
  add_index "haves", ["rayon_id"], :name => "rayon_id"
  add_index "haves", ["street_id"], :name => "street_id"

  create_table "info_sources", :force => true do |t|
    t.string   "name",       :limit => 80,  :null => false
    t.string   "info_url",   :limit => 200, :null => false
    t.integer  "info_type",  :limit => 2,   :null => false
    t.string   "address",    :limit => 100, :null => false
    t.string   "tel_1",      :limit => 80,  :null => false
    t.string   "dop",        :limit => 80,  :null => false
    t.datetime "created_at",                :null => false
    t.integer  "city_id",                   :null => false
  end

  create_table "info_types", :force => true do |t|
    t.string "name", :limit => 80, :null => false
  end

  create_table "kharkov_streets", :id => false, :force => true do |t|
    t.integer "id",                           :null => false
    t.string  "name",           :limit => 80
    t.string  "name_ukr",       :limit => 80, :null => false
    t.integer "id_street_ukr",                :null => false
    t.integer "id_city",                      :null => false
    t.integer "id_rayon",                     :null => false
    t.integer "id_rayon_admin"
  end

  create_table "kurs", :force => true do |t|
    t.string   "name",       :limit => 30
    t.float    "kurs_value"
    t.datetime "updated_at"
  end

  create_table "market_prices", :force => true do |t|
    t.integer  "obj_id"
    t.integer  "room"
    t.integer  "s_all"
    t.integer  "rayon_id"
    t.decimal  "price_min",               :precision => 12, :scale => 2
    t.decimal  "price_max",               :precision => 12, :scale => 2
    t.decimal  "price",                   :precision => 12, :scale => 2
    t.decimal  "price_1m2",               :precision => 10, :scale => 0
    t.text     "price_from"
    t.decimal  "price_1",                 :precision => 10, :scale => 0
    t.decimal  "price_2",                 :precision => 10, :scale => 0
    t.decimal  "price_3",                 :precision => 10, :scale => 0
    t.decimal  "price_4",                 :precision => 10, :scale => 0
    t.decimal  "price_5",                 :precision => 10, :scale => 0
    t.decimal  "price_6",                 :precision => 10, :scale => 0
    t.decimal  "price_7",                 :precision => 10, :scale => 0
    t.integer  "cnt_1",      :limit => 2,                                :default => 0, :null => false
    t.integer  "cnt_2",      :limit => 2,                                :default => 0, :null => false
    t.integer  "cnt_3",      :limit => 2,                                :default => 0, :null => false
    t.datetime "created_at",                                                            :null => false
    t.datetime "updated_at",                                                            :null => false
  end

  create_table "mobilecodes", :force => true do |t|
    t.string "name",  :limit => 80,  :null => false
    t.string "codes", :limit => 120, :null => false
  end

  create_table "obj_estimates", :id => false, :force => true do |t|
    t.integer  "id",                        :null => false
    t.integer  "city_id"
    t.integer  "obj_id",                    :null => false
    t.integer  "obj_atrib_id",              :null => false
    t.integer  "rayon_id",                  :null => false
    t.integer  "room",         :limit => 2, :null => false
    t.date     "created_at"
    t.datetime "updated_at",                :null => false
    t.float    "price"
    t.float    "price_1m2"
    t.integer  "id_cur",       :limit => 2
  end

  add_index "obj_estimates", ["id"], :name => "id", :unique => true

  create_table "objs", :force => true do |t|
    t.string "name",      :limit => 20, :null => false
    t.string "full_name", :limit => 80
  end

  create_table "plans", :id => false, :force => true do |t|
    t.integer "id",      :null => false
    t.integer "room",    :null => false
    t.integer "formula", :null => false
  end

  create_table "rayons", :force => true do |t|
    t.integer "parent",                 :null => false
    t.string  "name",    :limit => 80
    t.integer "city_id",                :null => false
    t.integer "level",   :limit => 2
    t.string  "contur",  :limit => 355, :null => false
  end

  add_index "rayons", ["city_id"], :name => "city_id"
  add_index "rayons", ["level"], :name => "level"
  add_index "rayons", ["parent"], :name => "parent"

  create_table "rayons_admins", :force => true do |t|
    t.string  "name",    :limit => 80
    t.integer "city_id"
  end

  create_table "rayons_admins_streets", :id => false, :force => true do |t|
    t.integer "rayons_admin_id", :null => false
    t.integer "street_id",       :null => false
  end

  add_index "rayons_admins_streets", ["rayons_admin_id"], :name => "rayons_admin_id"
  add_index "rayons_admins_streets", ["street_id"], :name => "street_id"

  create_table "rayons_streets", :id => false, :force => true do |t|
    t.integer "rayon_id",  :null => false
    t.integer "street_id", :null => false
  end

  add_index "rayons_streets", ["rayon_id"], :name => "rayon_id"
  add_index "rayons_streets", ["street_id"], :name => "street_id"

  create_table "states", :force => true do |t|
    t.integer "obj_id",               :null => false
    t.string  "name",   :limit => 20, :null => false
  end

  add_index "states", ["obj_id"], :name => "obj_id"

  create_table "statuses", :force => true do |t|
    t.string "name"
  end

  create_table "streets", :force => true do |t|
    t.string  "name",       :limit => 80,                                 :null => false
    t.string  "name_rus",   :limit => 80,                                 :null => false
    t.string  "contur",     :limit => 200
    t.decimal "center_lat",                :precision => 12, :scale => 6
    t.decimal "center_lng",                :precision => 12, :scale => 6
  end

  add_index "streets", ["id"], :name => "id"

  create_table "wants", :force => true do |t|
    t.integer  "zayavka_id"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.integer  "obj_id"
    t.integer  "room",       :limit => 2
    t.integer  "rayon_id"
    t.integer  "type_op",    :limit => 2
    t.integer  "price_want", :limit => 8,  :default => 0, :null => false
    t.string   "dop",        :limit => 80
    t.string   "tel_1",      :limit => 80
    t.string   "tel_2",      :limit => 80
    t.integer  "contact_id"
    t.integer  "variant",    :limit => 2,  :default => 1
  end

  add_index "wants", ["contact_id"], :name => "contact_id"
  add_index "wants", ["obj_id"], :name => "obj_id"
  add_index "wants", ["rayon_id"], :name => "rayon_id"
  add_index "wants", ["zayavka_id"], :name => "zayavka_id"

  create_table "wish_lists", :force => true do |t|
    t.integer "want_id",                                  :null => false
    t.integer "want_cnt",                  :default => 0, :null => false
    t.string  "field_name",  :limit => 20,                :null => false
    t.string  "field_cond",  :limit => 10,                :null => false
    t.string  "field_value", :limit => 80,                :null => false
    t.integer "variant",     :limit => 2,                 :null => false
  end

  add_index "wish_lists", ["want_id"], :name => "want_id"

  create_table "zayavkas", :force => true do |t|
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "info_type_id",                 :null => false
    t.integer  "info_source_id",               :null => false
    t.string   "tel_1",          :limit => 80, :null => false
    t.string   "tel_2",          :limit => 80, :null => false
    t.string   "name",           :limit => 80, :null => false
    t.string   "dop",            :limit => 80, :null => false
    t.integer  "contact_id",                   :null => false
    t.integer  "status_id",                    :null => false
    t.boolean  "published",                    :null => false
  end

  add_index "zayavkas", ["contact_id"], :name => "contact_id"
  add_index "zayavkas", ["id"], :name => "id"
  add_index "zayavkas", ["info_source_id"], :name => "info_source_id"
  add_index "zayavkas", ["info_type_id"], :name => "info_type_id"

end
