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

ActiveRecord::Schema.define(version: 20151015190030) do

  create_table "applications", force: :cascade do |t|
    t.string   "state",      limit: 255,                 null: false
    t.boolean  "ineligible", limit: 1,   default: false, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "sponsor_groups", force: :cascade do |t|
    t.string   "name",                              limit: 255, null: false
    t.string   "phone",                             limit: 255, null: false
    t.string   "email",                             limit: 255, null: false
    t.string   "address_line_1",                    limit: 255
    t.string   "address_line_2",                    limit: 255
    t.string   "city",                              limit: 255
    t.string   "postal_code",                       limit: 255
    t.string   "citizenship_status",                limit: 255
    t.boolean  "connected_to_refugee",              limit: 1
    t.string   "refugee_connection_type",           limit: 255
    t.boolean  "refugee_outside_country_of_origin", limit: 1
    t.integer  "group_size",                        limit: 4
    t.boolean  "sah_connection",                    limit: 1
    t.boolean  "interpreter_needed",                limit: 1
    t.boolean  "sufficient_resources",              limit: 1
    t.boolean  "criminal_record",                   limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
