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

ActiveRecord::Schema.define(:version => 20121118041937) do

  create_table "accesses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "user_level"
    t.datetime "access_time"
    t.text     "transaction_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "battle_records", :force => true do |t|
    t.integer  "req_user_id"
    t.integer  "res_user_id"
    t.integer  "battle_status"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "selected_cards", :force => true do |t|
    t.integer  "battle_id"
    t.integer  "user_id"
    t.integer  "turn_num"
    t.integer  "card_num"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "user_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "using_cards", :force => true do |t|
    t.integer  "battle_id"
    t.integer  "user_id"
    t.integer  "card_num"
    t.integer  "beetlekit_id"
    t.text     "image_id"
    t.text     "image_file_name"
    t.text     "beetle_name"
    t.integer  "type"
    t.text     "intro"
    t.integer  "attack"
    t.integer  "defense"
    t.integer  "attribute"
    t.text     "effect"
    t.integer  "effect_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
