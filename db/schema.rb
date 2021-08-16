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

ActiveRecord::Schema.define(version: 2019_05_09_201409) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chat_messages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "kind", limit: 2, null: false
    t.integer "id_for_language", null: false
    t.string "text", null: false
    t.string "ip_address", null: false
    t.string "language", null: false
    t.index ["language"], name: "index_chat_messages_on_language"
  end

  create_table "vote_histories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "language", null: false
    t.index ["language"], name: "index_vote_histories_on_language"
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
