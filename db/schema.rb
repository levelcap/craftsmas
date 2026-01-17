# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_01_17_181546) do
  create_table "gift_exchange_draws", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "gift_exchange_id"
    t.integer "giftee_id"
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["gift_exchange_id"], name: "index_gift_exchange_draws_on_gift_exchange_id"
    t.index ["giftee_id"], name: "index_gift_exchange_draws_on_giftee_id"
    t.index ["user_id"], name: "index_gift_exchange_draws_on_user_id"
  end

  create_table "gift_exchange_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "gift_exchange_id"
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["gift_exchange_id"], name: "index_gift_exchange_users_on_gift_exchange_id"
    t.index ["user_id"], name: "index_gift_exchange_users_on_user_id"
  end

  create_table "gift_exchanges", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.date "draw_date"
    t.date "event_date"
    t.string "name"
    t.datetime "updated_at", null: false
    t.integer "year"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "password_hash"
    t.string "password_salt"
    t.datetime "updated_at", null: false
  end

  create_table "wishlist_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.datetime "updated_at", null: false
    t.integer "wishlist_id"
    t.index ["wishlist_id"], name: "index_wishlist_items_on_wishlist_id"
  end

  create_table "wishlists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_wishlists_on_user_id"
  end

  add_foreign_key "gift_exchange_draws", "gift_exchanges"
  add_foreign_key "gift_exchange_draws", "users"
  add_foreign_key "gift_exchange_draws", "users", column: "giftee_id"
  add_foreign_key "gift_exchange_users", "gift_exchanges"
  add_foreign_key "gift_exchange_users", "users"
end
