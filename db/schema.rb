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

ActiveRecord::Schema.define(version: 20170506154731) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "ftes", force: :cascade do |t|
    t.date     "startdate"
    t.date     "enddate"
    t.integer  "staff_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "FTE_value"
    t.index ["staff_id"], name: "index_ftes_on_staff_id", using: :btree
  end

  create_table "line_staffs", force: :cascade do |t|
    t.integer  "staff_id"
    t.integer  "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "grade"
    t.index ["staff_id"], name: "index_line_staffs_on_staff_id", using: :btree
    t.index ["task_id"], name: "index_line_staffs_on_task_id", using: :btree
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
    t.index ["updated_at"], name: "index_sessions_on_updated_at", using: :btree
  end

  create_table "staffs", force: :cascade do |t|
    t.string   "name"
    t.integer  "grade"
    t.date     "startdate"
    t.date     "enddate"
    t.string   "FTE"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "allocatedtime",  default: 0
    t.string   "staffgivenname"
  end

  create_table "studies", force: :cascade do |t|
    t.string   "title"
    t.date     "startdate"
    t.date     "enddate"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "title"
    t.date     "startdate"
    t.date     "enddate"
    t.integer  "lead_dm_time"
    t.integer  "dm_time"
    t.integer  "support_dm_time"
    t.integer  "study_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["study_id"], name: "index_tasks_on_study_id", using: :btree
  end

  create_table "time_managements", force: :cascade do |t|
    t.decimal  "chart_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "year"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",              default: "", null: false
    t.integer  "sign_in_count",      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "username"
    t.string   "uid"
    t.string   "mail"
    t.string   "ou"
    t.string   "dn"
    t.string   "sn"
    t.string   "givenname"
    t.integer  "role"
    t.integer  "grade"
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["username"], name: "index_users_on_username", using: :btree
  end

  add_foreign_key "ftes", "staffs"
  add_foreign_key "line_staffs", "staffs"
  add_foreign_key "line_staffs", "tasks"
  add_foreign_key "tasks", "studies"
end
