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

ActiveRecord::Schema.define(version: 20210405154447) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "question_templates", force: :cascade do |t|
    t.string  "question_type"
    t.string  "text"
    t.json    "answers"
    t.json    "true_answers"
    t.integer "test_template_id"
    t.index ["test_template_id"], name: "index_question_templates_on_test_template_id", using: :btree
  end

  create_table "questions", force: :cascade do |t|
    t.json    "user_answers"
    t.integer "users_id"
    t.integer "tests_id"
    t.integer "question_templates_id"
    t.index ["question_templates_id"], name: "index_questions_on_question_templates_id", using: :btree
    t.index ["tests_id"], name: "index_questions_on_tests_id", using: :btree
    t.index ["users_id"], name: "index_questions_on_users_id", using: :btree
  end

  create_table "recommends", force: :cascade do |t|
    t.string   "recommend_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id", using: :btree
    t.index ["updated_at"], name: "index_sessions_on_updated_at", using: :btree
  end

  create_table "students", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.integer  "student_id"
    t.integer  "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_subjects_on_student_id", using: :btree
    t.index ["teacher_id"], name: "index_subjects_on_teacher_id", using: :btree
  end

  create_table "teachers", force: :cascade do |t|
    t.integer  "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "test_recommends", force: :cascade do |t|
    t.integer "recommend_id"
    t.integer "test_template_id"
    t.index ["recommend_id"], name: "index_test_recommends_on_recommend_id", using: :btree
    t.index ["test_template_id"], name: "index_test_recommends_on_test_template_id", using: :btree
  end

  create_table "test_templates", force: :cascade do |t|
    t.string   "title"
    t.string   "sub_title"
    t.integer  "likes"
    t.integer  "plays"
    t.json     "colors"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_test_templates_on_user_id", using: :btree
  end

  create_table "tests", force: :cascade do |t|
    t.integer  "users_id"
    t.integer  "test_templates_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.json     "user_data",         default: {}
    t.index ["test_templates_id"], name: "index_tests_on_test_templates_id", using: :btree
    t.index ["users_id"], name: "index_tests_on_users_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "subjects", "students"
  add_foreign_key "subjects", "teachers"
  add_foreign_key "test_recommends", "recommends"
  add_foreign_key "test_recommends", "test_templates"
end
