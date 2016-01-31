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

ActiveRecord::Schema.define(version: 20160131165000) do

  create_table "archive_sources", id: false, force: :cascade do |t|
    t.integer  "archive_id"
    t.integer  "source_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "archive_sources", ["archive_id"], name: "index_archive_sources_on_archive_id"
  add_index "archive_sources", ["source_id"], name: "index_archive_sources_on_source_id"

  create_table "archive_storages", id: false, force: :cascade do |t|
    t.integer  "archive_id"
    t.integer  "storage_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "archive_storages", ["archive_id"], name: "index_archive_storages_on_archive_id"
  add_index "archive_storages", ["storage_id"], name: "index_archive_storages_on_storage_id"

  create_table "archives", force: :cascade do |t|
    t.string   "title"
    t.string   "abbr"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "archives", ["abbr"], name: "index_archives_on_abbr", unique: true
  add_index "archives", ["title"], name: "index_archives_on_title", unique: true

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
    t.string   "type"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "person_relations", ["person_id"], name: "index_person_relations_on_person_id"
  add_index "person_relations", ["related_id"], name: "index_person_relations_on_related_id"

  create_table "sources", force: :cascade do |t|
    t.string   "title"
    t.string   "source_type"
    t.text     "notes"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "storages", force: :cascade do |t|
    t.string   "title"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "storages", ["title"], name: "index_storages_on_title", unique: true

end
