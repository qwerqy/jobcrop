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

ActiveRecord::Schema.define(version: 2018_10_08_163752) do

  create_table "bookings", force: :cascade do |t|
    t.integer "user_id"
    t.integer "job_id"
    t.datetime "booked_at"
    t.string "files"
    t.string "detail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_bookings_on_job_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.string "description"
    t.string "requirement"
    t.integer "salary"
    t.string "image"
    t.datetime "session"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "fullname"
    t.string "role"
    t.string "email"
    t.string "password"
    t.string "password_digest"
    t.string "detail"
    t.string "image"
    t.string "checklist"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", limit: 128
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

end
