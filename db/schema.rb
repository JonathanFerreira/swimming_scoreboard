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

ActiveRecord::Schema[7.2].define(version: 2025_10_26_182911) do
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

  create_table "proof_categories", force: :cascade do |t|
    t.integer "proof_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_proof_categories_on_category_id"
    t.index ["proof_id"], name: "index_proof_categories_on_proof_id"
  end

  create_table "proof_category_swimmers", force: :cascade do |t|
    t.integer "proof_id", null: false
    t.integer "category_id", null: false
    t.integer "swimmer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "idx_proof_category_swimmers_on_category_id"
    t.index ["proof_id", "swimmer_id"], name: "idx_proof_category_swimmers_on_proof_id_swimmer_id", unique: true
    t.index ["proof_id"], name: "idx_proof_category_swimmers_on_proof_id"
    t.index ["swimmer_id"], name: "idx_proof_category_swimmers_on_swimmer_id"
  end

  create_table "proofs", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.integer "competition_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lane_quantity"
    t.index ["competition_id"], name: "index_proofs_on_competition_id"
    t.index ["lane_quantity"], name: "index_proofs_on_lane_quantity"
  end

  create_table "swimmers", force: :cascade do |t|
    t.string "name", null: false
    t.string "phone_number", null: false
    t.date "birthdate", null: false
    t.string "gender", null: false
    t.integer "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["birthdate"], name: "index_swimmers_on_birthdate"
    t.index ["gender"], name: "index_swimmers_on_gender"
    t.index ["name"], name: "index_swimmers_on_name", unique: true
    t.index ["phone_number"], name: "index_swimmers_on_phone_number"
    t.index ["team_id"], name: "index_swimmers_on_team_id"
  end

  create_table "swimming_marker_blocks", force: :cascade do |t|
    t.integer "swimming_marker_group_id", null: false
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["position"], name: "index_swimming_marker_blocks_on_position", unique: true
    t.index ["swimming_marker_group_id"], name: "index_swimming_marker_blocks_on_swimming_marker_group_id"
  end

  create_table "swimming_marker_groups", force: :cascade do |t|
    t.integer "proof_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_swimming_marker_groups_on_category_id"
    t.index ["proof_id"], name: "index_swimming_marker_groups_on_proof_id"
  end

  create_table "swimming_marker_lanes", force: :cascade do |t|
    t.integer "swimming_marker_block_id", null: false
    t.integer "swimmer_id", null: false
    t.integer "lane"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["swimmer_id"], name: "index_swimming_marker_lanes_on_swimmer_id"
    t.index ["swimming_marker_block_id", "lane"], name: "idx_on_swimming_marker_block_id_lane_10e8ac75a6", unique: true
    t.index ["swimming_marker_block_id", "swimmer_id"], name: "idx_swimming_marker_lanes_on_swimming_marker_block_id_swimmer_id", unique: true
    t.index ["swimming_marker_block_id"], name: "index_swimming_marker_lanes_on_swimming_marker_block_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_teams_on_name", unique: true
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

  add_foreign_key "proof_categories", "categories"
  add_foreign_key "proof_categories", "proofs"
  add_foreign_key "proof_category_swimmers", "categories"
  add_foreign_key "proof_category_swimmers", "proofs"
  add_foreign_key "proof_category_swimmers", "swimmers"
  add_foreign_key "proofs", "competitions"
  add_foreign_key "swimmers", "teams"
  add_foreign_key "swimming_marker_blocks", "swimming_marker_groups"
  add_foreign_key "swimming_marker_groups", "categories"
  add_foreign_key "swimming_marker_groups", "proofs"
  add_foreign_key "swimming_marker_lanes", "swimmers"
  add_foreign_key "swimming_marker_lanes", "swimming_marker_blocks"
end
