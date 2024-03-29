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

ActiveRecord::Schema[7.1].define(version: 2024_02_05_195238) do
  create_table "doctors", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "specialty"
    t.string "crm"
    t.string "email"
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sex"
  end

  create_table "schedules", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "doctor"
    t.string "specialty"
    t.string "crm"
    t.string "date"
    t.string "hour"
    t.string "patient_Name"
    t.string "patient_Email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "Active"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest", null: false
    t.boolean "admin", default: false
    t.string "email", null: false
    t.string "zipCode"
    t.string "adress"
    t.string "neighborhood"
    t.string "number_adress"
    t.string "contact_number"
    t.boolean "firstTime", default: false
    t.string "cpf"
  end

end
