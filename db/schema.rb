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

ActiveRecord::Schema.define(version: 20161205194612) do

  create_table "admins", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tournament_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["tournament_id"], name: "index_admins_on_tournament_id"
    t.index ["user_id"], name: "index_admins_on_user_id"
  end

  create_table "contact_players", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contactforms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "ticket_option_id"
    t.index ["team_id"], name: "index_players_on_team_id"
    t.index ["ticket_option_id"], name: "index_players_on_ticket_option_id"
    t.index ["user_id"], name: "index_players_on_user_id"
  end

  create_table "reg_sponsors", force: :cascade do |t|
    t.text     "name"
    t.text     "ttype"
    t.text     "website"
    t.integer  "tournament_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "scores", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "hole"
    t.integer  "strokes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_scores_on_player_id"
  end

  create_table "sponsor_options", force: :cascade do |t|
    t.text     "ttype"
    t.decimal  "price"
    t.integer  "tournament_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "sponsors", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tournament_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "sponsor_opt_id"
    t.index ["tournament_id"], name: "index_sponsors_on_tournament_id"
    t.index ["user_id"], name: "index_sponsors_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.integer  "tournament_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "name"
    t.index ["tournament_id"], name: "index_teams_on_tournament_id"
  end

  create_table "ticket_options", force: :cascade do |t|
    t.string   "ttype"
    t.decimal  "price"
    t.integer  "tournament_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "tournaments", force: :cascade do |t|
    t.string   "title"
    t.string   "location"
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.text     "description"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "is_private"
    t.string   "golf_format"
    t.text     "schedule"
    t.text     "features"
    t.string   "email"
    t.string   "phone"
    t.integer  "player_limit"
    t.string   "logo"
  end

  create_table "users", force: :cascade do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "email"
    t.string   "phone"
    t.string   "addr"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.text     "bio"
    t.string   "user_image"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
