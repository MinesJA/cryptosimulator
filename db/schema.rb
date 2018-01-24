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
#
######=======>>>> should we have a default value of timestamp for coin_transaction_date?
######===>>>> Could be useful for seeding data with made up date transactions
######=======>>>> should we add a date (includes same default as above) for usd transactions?

ActiveRecord::Schema.define(version: 20180123210045) do

  create_table "coin_transactions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "coin_id"
    t.float "coin_amount"
    t.float "coin_price"
    t.datetime "coin_transaction_date"
  end

  create_table "coins", force: :cascade do |t|
    t.string "coin_name"
    t.float "coin_price"
    t.float "coin_marketcap"
  end

  create_table "usd_transactions", force: :cascade do |t|
    t.integer "user_id"
    t.float "usd_amount"
    t.string "usd_transaction_type"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.string "country"
  end

end