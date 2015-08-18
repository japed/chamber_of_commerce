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

ActiveRecord::Schema.define(version: 20150812100420) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "additional_contents", force: :cascade do |t|
    t.string   "area"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "article_categories", force: :cascade do |t|
    t.string   "title",                          null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "slug"
    t.boolean  "member_related", default: false
  end

  add_index "article_categories", ["slug"], name: "index_article_categories_on_slug", using: :btree

  create_table "articles", force: :cascade do |t|
    t.string   "title",                              null: false
    t.integer  "article_category_id"
    t.text     "summary"
    t.text     "content"
    t.string   "image"
    t.date     "date"
    t.boolean  "display",             default: true
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "suggested_url"
    t.string   "slug"
  end

  add_index "articles", ["article_category_id"], name: "index_articles_on_article_category_id", using: :btree
  add_index "articles", ["slug"], name: "index_articles_on_slug", unique: true, using: :btree

  create_table "attendee_event_agendas", force: :cascade do |t|
    t.integer  "attendee_id"
    t.integer  "event_agenda_id"
    t.decimal  "price",           precision: 8, scale: 2, default: 0.0
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
  end

  add_index "attendee_event_agendas", ["attendee_id"], name: "index_attendee_event_agendas_on_attendee_id", using: :btree
  add_index "attendee_event_agendas", ["event_agenda_id"], name: "index_attendee_event_agendas_on_event_agenda_id", using: :btree

  create_table "attendees", force: :cascade do |t|
    t.integer  "event_booking_id"
    t.string   "phone_number"
    t.string   "email"
    t.text     "dietary_requirements"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "attendees", ["event_booking_id"], name: "index_attendees_on_event_booking_id", using: :btree

  create_table "event_agendas", force: :cascade do |t|
    t.string   "name",                                                    null: false
    t.integer  "event_category_id"
    t.time     "start_time"
    t.time     "end_time"
    t.text     "description"
    t.integer  "maximum_capacity"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.integer  "event_id"
    t.decimal  "price",             precision: 8, scale: 2, default: 0.0
  end

  add_index "event_agendas", ["event_category_id"], name: "index_event_agendas_on_event_category_id", using: :btree
  add_index "event_agendas", ["event_id"], name: "index_event_agendas_on_event_id", using: :btree

  create_table "event_bookings", force: :cascade do |t|
    t.integer  "event_id"
    t.string   "name",                               null: false
    t.string   "company_name"
    t.string   "industry"
    t.string   "nature_of_business"
    t.text     "address"
    t.string   "phone_number"
    t.string   "email"
    t.boolean  "paid",               default: false
    t.integer  "attendees_count",    default: 0
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "event_bookings", ["event_id"], name: "index_event_bookings_on_event_id", using: :btree

  create_table "event_categories", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "name",                         null: false
    t.boolean  "has_tables"
    t.boolean  "food_event"
    t.boolean  "bookable",      default: true
    t.string   "suggested_url"
    t.string   "slug"
    t.integer  "position"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "event_category_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "event_category_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "event_category_anc_desc_idx", unique: true, using: :btree
  add_index "event_category_hierarchies", ["descendant_id"], name: "event_category_desc_idx", using: :btree

  create_table "event_locations", force: :cascade do |t|
    t.string   "address_line_1", null: false
    t.string   "address_line_2"
    t.string   "city",           null: false
    t.string   "region"
    t.string   "post_code"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "location_name"
    t.string   "slug"
  end

  create_table "events", force: :cascade do |t|
    t.string   "name",                               null: false
    t.integer  "event_agendas_id"
    t.date     "start_date",                         null: false
    t.date     "end_date",                           null: false
    t.string   "image"
    t.integer  "event_location_id"
    t.text     "description"
    t.boolean  "display",             default: true
    t.integer  "event_agendas_count", default: 0
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "suggested_url"
    t.string   "slug"
    t.text     "summary"
  end

  add_index "events", ["event_agendas_id"], name: "index_events_on_event_agendas_id", using: :btree
  add_index "events", ["event_location_id"], name: "index_events_on_event_location_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "internal_promotions", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "image",                     null: false
    t.string   "link"
    t.string   "area",                      null: false
    t.boolean  "display",    default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "magazines", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "file"
    t.date     "date"
    t.string   "image"
    t.boolean  "display",    default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "member_logins", force: :cascade do |t|
    t.integer  "member_id"
    t.string   "username"
    t.string   "password_digest"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.boolean  "active",               default: true
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "member_logins", ["member_id"], name: "index_member_logins_on_member_id", using: :btree

  create_table "member_offers", force: :cascade do |t|
    t.integer  "member_id"
    t.string   "title",        null: false
    t.text     "summary",      null: false
    t.text     "description"
    t.string   "website_link"
    t.string   "image"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "verified"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "slug"
  end

  add_index "member_offers", ["member_id"], name: "index_member_offers_on_member_id", using: :btree

  create_table "members", force: :cascade do |t|
    t.string   "company_name"
    t.string   "industry"
    t.text     "address"
    t.string   "telephone"
    t.string   "website"
    t.string   "email"
    t.boolean  "verified"
    t.text     "nature_of_business"
    t.integer  "member_login_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "slug"
    t.integer  "member_offers_count", default: 0
  end

  add_index "members", ["member_login_id"], name: "index_members_on_member_login_id", using: :btree

  create_table "newsletter_signups", force: :cascade do |t|
    t.string   "email_address"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "optimadmin_administrators", force: :cascade do |t|
    t.string   "username",               null: false
    t.string   "email",                  null: false
    t.string   "role",                   null: false
    t.string   "auth_token"
    t.string   "password_digest",        null: false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "optimadmin_administrators", ["auth_token"], name: "index_optimadmin_administrators_on_auth_token", using: :btree
  add_index "optimadmin_administrators", ["email"], name: "index_optimadmin_administrators_on_email", using: :btree
  add_index "optimadmin_administrators", ["username"], name: "index_optimadmin_administrators_on_username", using: :btree

  create_table "optimadmin_documents", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "document",    null: false
    t.string   "module_name"
    t.integer  "module_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "optimadmin_external_links", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "optimadmin_images", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "image",       null: false
    t.string   "string"
    t.integer  "module_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "module_name"
  end

  create_table "optimadmin_links", force: :cascade do |t|
    t.string   "menu_resource_type"
    t.integer  "menu_resource_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "optimadmin_menu_item_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "optimadmin_menu_item_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "menu_item_anc_desc_idx", unique: true, using: :btree
  add_index "optimadmin_menu_item_hierarchies", ["descendant_id"], name: "menu_item_desc_idx", using: :btree

  create_table "optimadmin_menu_items", force: :cascade do |t|
    t.string   "menu_name",       limit: 100
    t.string   "name",            limit: 100
    t.integer  "parent_id"
    t.boolean  "deletable",                   default: true
    t.boolean  "new_window",                  default: false
    t.string   "title_attribute", limit: 100
    t.integer  "position",                    default: 0
    t.integer  "link_id"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "optimadmin_menu_items", ["link_id"], name: "index_optimadmin_menu_items_on_link_id", using: :btree

  create_table "optimadmin_module_pages", force: :cascade do |t|
    t.string   "name"
    t.string   "route"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "optimadmin_site_settings", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.string "environment"
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title",                        null: false
    t.text     "content"
    t.string   "image"
    t.boolean  "display",       default: true
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "slug"
    t.string   "suggested_url"
    t.string   "style"
    t.string   "layout"
    t.string   "page_type"
  end

  create_table "patrons", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "image",                     null: false
    t.string   "link"
    t.boolean  "display",    default: true
    t.integer  "position",   default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_foreign_key "articles", "article_categories"
  add_foreign_key "attendee_event_agendas", "attendees"
  add_foreign_key "attendee_event_agendas", "event_agendas"
  add_foreign_key "attendees", "event_bookings"
  add_foreign_key "event_agendas", "event_categories"
  add_foreign_key "event_agendas", "events"
  add_foreign_key "event_bookings", "events"
  add_foreign_key "member_logins", "members"
  add_foreign_key "member_offers", "members"
end
