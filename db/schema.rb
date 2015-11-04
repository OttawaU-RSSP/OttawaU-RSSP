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

ActiveRecord::Schema.define(version: 20151103041813) do

  create_table "applications", force: :cascade do |t|
    t.string   "state",            limit: 255,                 null: false
    t.boolean  "ineligible",       limit: 1,   default: false, null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "sponsor_group_id", limit: 4
  end

  add_index "applications", ["sponsor_group_id"], name: "index_applications_on_sponsor_group_id", using: :btree

  create_table "assignees", force: :cascade do |t|
    t.integer  "application_id", limit: 4
    t.integer  "user_id",        limit: 4
    t.boolean  "primary",        limit: 1, default: false, null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "assignees", ["application_id"], name: "index_assignees_on_application_id", using: :btree
  add_index "assignees", ["user_id"], name: "index_assignees_on_user_id", using: :btree

  create_table "lawyers", force: :cascade do |t|
    t.string  "address1",                                           limit: 255
    t.string  "city",                                               limit: 255
    t.string  "province",                                           limit: 255
    t.string  "telephone",                                          limit: 255
    t.string  "employer_name",                                      limit: 255
    t.string  "employer_address",                                   limit: 255
    t.string  "employment_type",                                    limit: 255
    t.boolean "practicing",                                         limit: 1
    t.integer "year_of_call",                                       limit: 4
    t.string  "law_society",                                        limit: 255
    t.text    "areas_of_practice",                                  limit: 65535
    t.string  "language_of_practice",                               limit: 255
    t.boolean "experience_with_refugee_sponsorships",               limit: 1
    t.text    "experience_with_refugee_sponsorships_clarification", limit: 65535
    t.boolean "insurance",                                          limit: 1
    t.boolean "can_accomodate_meetings",                            limit: 1
    t.text    "areas_of_interest",                                  limit: 65535
    t.text    "comments",                                           limit: 65535
    t.text    "private_notes",                                      limit: 65535
  end

  create_table "sponsor_groups", force: :cascade do |t|
    t.string   "name",                                limit: 255,   null: false
    t.string   "phone",                               limit: 255,   null: false
    t.string   "email",                               limit: 255,   null: false
    t.string   "address_line_1",                      limit: 255
    t.string   "address_line_2",                      limit: 255
    t.string   "city",                                limit: 255
    t.string   "postal_code",                         limit: 255
    t.string   "citizenship_status",                  limit: 255
    t.boolean  "connected_to_refugee",                limit: 1
    t.string   "refugee_connection_type",             limit: 255
    t.boolean  "refugee_outside_country_of_origin",   limit: 1
    t.integer  "group_size",                          limit: 4
    t.boolean  "sah_connection",                      limit: 1
    t.boolean  "interpreter_needed",                  limit: 1
    t.boolean  "sufficient_resources",                limit: 1
    t.boolean  "criminal_record",                     limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "province",                            limit: 255
    t.text     "public_notes",                        limit: 65535
    t.text     "private_notes",                       limit: 65535
    t.boolean  "proper_group_size",                   limit: 1
    t.string   "refugee_name",                        limit: 255
    t.string   "refugee_nationality",                 limit: 255
    t.string   "refugee_current_location",            limit: 255
    t.boolean  "connect_refugee_family_in_canada",    limit: 1
    t.boolean  "connect_refugee_no_family_in_canada", limit: 1
    t.text     "public_meeting_notes",                limit: 65535
    t.text     "private_meeting_notes",               limit: 65535
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "name",               limit: 255,   null: false
    t.string   "email",              limit: 255,   null: false
    t.string   "encrypted_password", limit: 128,   null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128,   null: false
    t.boolean  "approved",           limit: 1
    t.string   "type",               limit: 255
    t.text     "extra",              limit: 65535
    t.integer  "user_id",            limit: 4
    t.string   "user_type",          limit: 255
    t.string   "activation_token",   limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  add_foreign_key "assignees", "applications"
  add_foreign_key "assignees", "users"
end
