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

ActiveRecord::Schema.define(version: 2019_05_09_201409) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chat_messages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "kind", limit: 2, null: false
    t.string "text", null: false
    t.string "ip_address", null: false
  end

  create_table "vote_histories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vote_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "ip_address", null: false
    t.integer "total_vote_count", null: false
    t.datetime "reset_at", null: false
    t.index ["name"], name: "index_vote_users_on_name", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "vote_count", null: false
    t.bigint "vote_user_id"
    t.bigint "vote_history_id"
    t.index ["vote_history_id"], name: "index_votes_on_vote_history_id"
    t.index ["vote_user_id"], name: "index_votes_on_vote_user_id"
  end

  add_foreign_key "votes", "vote_histories"
  add_foreign_key "votes", "vote_users"
end
