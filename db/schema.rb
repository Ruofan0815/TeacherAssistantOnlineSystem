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

ActiveRecord::Schema.define(version: 20190122224541) do

  create_table "classtimes", force: :cascade do |t|
    t.string "day"
    t.string "start"
    t.string "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_classtimes", force: :cascade do |t|
    t.integer "course_id"
    t.integer "classtime_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classtime_id"], name: "index_course_classtimes_on_classtime_id"
    t.index ["course_id"], name: "index_course_classtimes_on_course_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.string "course_number"
    t.integer "section"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ctimes", force: :cascade do |t|
    t.string "day"
    t.string "start_time"
    t.string "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_course_takes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_user_course_takes_on_course_id"
    t.index ["user_id"], name: "index_user_course_takes_on_user_id"
  end

  create_table "user_course_teaches", force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_user_course_teaches_on_course_id"
    t.index ["user_id"], name: "index_user_course_teaches_on_user_id"
  end

  create_table "user_courses", force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
    t.string "relationtype"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_user_courses_on_course_id"
    t.index ["user_id"], name: "index_user_courses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "password_digest"
    t.boolean "admin", default: false
  end

end
