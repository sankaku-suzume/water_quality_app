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

ActiveRecord::Schema[7.2].define(version: 2025_09_28_084652) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "plants", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "location"
    t.text "remarks"
  end

  create_table "results", force: :cascade do |t|
    t.bigint "sample_id", null: false
    t.bigint "test_item_id", null: false
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sample_id"], name: "index_results_on_sample_id"
    t.index ["test_item_id"], name: "index_results_on_test_item_id"
  end

  create_table "samples", force: :cascade do |t|
    t.bigint "plant_id", null: false
    t.date "sampling_date", null: false
    t.time "sampling_time", null: false
    t.string "location"
    t.string "inspector"
    t.text "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plant_id"], name: "index_samples_on_plant_id"
  end

  create_table "test_items", force: :cascade do |t|
    t.string "name", null: false
    t.string "unit"
    t.float "detection_limit"
    t.float "standard_min"
    t.float "standard_max"
    t.integer "sort_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
end
