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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150108061520) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "project_shares", force: true do |t|
    t.integer  "project_id", null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_shares", ["project_id", "user_id"], name: "index_project_shares_on_project_id_and_user_id", unique: true, using: :btree

  create_table "projects", force: true do |t|
    t.string   "name",        null: false
    t.integer  "order",       null: false
    t.text     "description"
    t.integer  "user_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["name"], name: "index_projects_on_name", using: :btree
  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "two_way_plots", force: true do |t|
    t.string   "title",                   null: false
    t.string   "independent_variable",    null: false
    t.string   "moderator_variable",      null: false
    t.string   "dependent_variable",      null: false
    t.decimal  "independent_coefficient", null: false
    t.decimal  "moderator_coefficient",   null: false
    t.decimal  "interaction_coefficient", null: false
    t.decimal  "intercept",               null: false
    t.decimal  "independent_mean",        null: false
    t.decimal  "independent_sd",          null: false
    t.decimal  "moderator_mean",          null: false
    t.decimal  "moderator_sd",            null: false
    t.integer  "order",                   null: false
    t.integer  "project_id",              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "two_way_plots", ["order", "project_id"], name: "index_two_way_plots_on_order_and_project_id", unique: true, using: :btree
  add_index "two_way_plots", ["title"], name: "index_two_way_plots_on_title", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "session_token",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["session_token"], name: "index_users_on_session_token", unique: true, using: :btree

end
