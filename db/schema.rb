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

ActiveRecord::Schema[7.1].define(version: 2024_10_09_151823) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "data_kandangs", force: :cascade do |t|
    t.string "nama_kandang"
    t.integer "kapasitas"
    t.text "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_data_kandangs_on_user_id"
  end

  create_table "data_pemeriksaans", force: :cascade do |t|
    t.string "suhu"
    t.string "confidence"
    t.string "sel_somatik"
    t.string "device_identifier"
    t.bigint "data_sapi_id", null: false
    t.bigint "data_kandang_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_kandang_id"], name: "index_data_pemeriksaans_on_data_kandang_id"
    t.index ["data_sapi_id"], name: "index_data_pemeriksaans_on_data_sapi_id"
  end

  create_table "data_sapis", force: :cascade do |t|
    t.string "bangsa"
    t.string "jenis_kelamin"
    t.string "bobot"
    t.string "umur"
    t.bigint "data_kandang_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_kandang_id"], name: "index_data_sapis_on_data_kandang_id"
  end

  create_table "devices", force: :cascade do |t|
    t.string "device_identifier"
    t.string "device_name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_devices_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "phone_number"
    t.string "image"
    t.string "password_digest"
    t.string "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "data_kandangs", "users"
  add_foreign_key "data_pemeriksaans", "data_kandangs"
  add_foreign_key "data_pemeriksaans", "data_sapis"
  add_foreign_key "data_sapis", "data_kandangs"
  add_foreign_key "devices", "users"
end
