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

ActiveRecord::Schema.define(version: 20150308221038) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "notebooks", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notebooks_notes", id: false, force: true do |t|
    t.integer "note_id",     null: false
    t.integer "notebook_id", null: false
  end

  add_index "notebooks_notes", ["note_id", "notebook_id"], name: "index_notebooks_notes_on_note_id_and_notebook_id", using: :btree
  add_index "notebooks_notes", ["notebook_id", "note_id"], name: "index_notebooks_notes_on_notebook_id_and_note_id", using: :btree

  create_table "notes", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.hstore   "metadata"
    t.boolean  "archived"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category",                default: "text"
    t.string   "file_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

end
