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

ActiveRecord::Schema[7.2].define(version: 2025_10_20_225826) do
  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.integer "age_min", null: false
    t.integer "age_max", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["age_max"], name: "index_categories_on_age_max"
    t.index ["age_min"], name: "index_categories_on_age_min"
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "competitions", force: :cascade do |t|
    t.string "name"
    t.date "event_initial_date"
    t.date "event_final_date"
    t.string "address"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "proofs", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.integer "competition_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["competition_id"], name: "index_proofs_on_competition_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "proofs", "competitions"
end
