# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160406143225) do

  create_table "authors", force: :cascade do |t|
    t.string   "name"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "collection_documents", force: :cascade do |t|
    t.integer  "collection_id"
    t.integer  "document_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "collection_documents", ["collection_id", "document_id"], name: "index_collection_documents_on_collection_id_and_document_id", unique: true

  create_table "collection_storages", force: :cascade do |t|
    t.integer  "collection_id"
    t.integer  "storage_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "collection_storages", ["collection_id", "storage_id"], name: "index_collection_storages_on_collection_id_and_storage_id", unique: true

  create_table "collections", force: :cascade do |t|
    t.string   "title"
    t.string   "abbr"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "collections", ["abbr"], name: "index_collections_on_abbr", unique: true
  add_index "collections", ["title"], name: "index_collections_on_title", unique: true

  create_table "content_translations", force: :cascade do |t|
    t.integer  "content_id"
    t.text     "translation"
    t.string   "language"
    t.text     "notes"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "contents", force: :cascade do |t|
    t.integer  "deed_id"
    t.text     "content"
    t.string   "language"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deeds", force: :cascade do |t|
    t.string   "title"
    t.integer  "year"
    t.integer  "month"
    t.integer  "day"
    t.text     "description"
    t.text     "notes"
    t.integer  "seal_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "deeds", ["seal_id"], name: "index_deeds_on_seal_id"
  add_index "deeds", ["title", "year", "month", "day"], name: "index_deeds_on_title_and_year_and_month_and_day", unique: true

  create_table "deeds_references", force: :cascade do |t|
    t.integer "deed_id"
    t.integer "reference_id"
  end

  add_index "deeds_references", ["deed_id"], name: "index_deeds_references_on_deed_id"
  add_index "deeds_references", ["reference_id"], name: "index_deeds_references_on_reference_id"

  create_table "documents", force: :cascade do |t|
    t.string   "title"
    t.string   "document_type"
    t.text     "notes"
    t.integer  "deed_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "documents", ["deed_id"], name: "index_documents_on_deed_id"

  create_table "mentions", force: :cascade do |t|
    t.integer  "deed_id"
    t.integer  "person_id"
    t.integer  "role_id"
    t.integer  "place_id"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "gender"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "people", ["name", "gender"], name: "index_people_on_name_and_gender"

  create_table "person_relations", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "related_id"
    t.string   "relation_type"
    t.text     "notes"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "person_relations", ["person_id"], name: "index_person_relations_on_person_id"
  add_index "person_relations", ["related_id"], name: "index_person_relations_on_related_id"

  create_table "place_relations", force: :cascade do |t|
    t.integer  "place_id"
    t.integer  "related_id"
    t.string   "relation_type"
    t.text     "notes"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "place_relations", ["place_id"], name: "index_place_relations_on_place_id"
  add_index "place_relations", ["related_id"], name: "index_place_relations_on_related_id"

  create_table "places", force: :cascade do |t|
    t.string   "title"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "references", force: :cascade do |t|
    t.string   "title"
    t.string   "container"
    t.integer  "year"
    t.string   "place"
    t.string   "authors"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "references_seals", force: :cascade do |t|
    t.integer "reference_id"
    t.integer "seal_id"
  end

  add_index "references_seals", ["reference_id"], name: "index_references_seals_on_reference_id"
  add_index "references_seals", ["seal_id"], name: "index_references_seals_on_seal_id"

  create_table "roles", force: :cascade do |t|
    t.string   "title"
    t.string   "referring"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seals", force: :cascade do |t|
    t.string   "title"
    t.string   "material"
    t.string   "attachment_type"
    t.text     "notes"
    t.integer  "deed_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "seals", ["deed_id"], name: "index_seals_on_deed_id"

  create_table "storages", force: :cascade do |t|
    t.string   "title"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "storages", ["title"], name: "index_storages_on_title", unique: true

end
