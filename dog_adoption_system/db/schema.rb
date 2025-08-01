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

ActiveRecord::Schema[8.0].define(version: 2025_07_28_045640) do
  create_table "adoptions", force: :cascade do |t|
    t.integer "dog_id", null: false
    t.integer "owner_id", null: false
    t.date "adoption_date"
    t.decimal "adoption_fee"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dog_id"], name: "index_adoptions_on_dog_id"
    t.index ["owner_id"], name: "index_adoptions_on_owner_id"
  end

  create_table "dogs", force: :cascade do |t|
    t.string "breed"
    t.string "name"
    t.integer "age"
    t.string "image_url"
    t.text "description"
    t.boolean "available_for_adoption"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "owners", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "adoptions", "dogs"
  add_foreign_key "adoptions", "owners"
end
