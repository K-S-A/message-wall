# encoding: UTF-8
ActiveRecord::Schema.define(version: 20160301222536) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "message_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "message_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "message_anc_desc_idx", unique: true, using: :btree
  add_index "message_hierarchies", ["descendant_id"], name: "message_desc_idx", using: :btree

  create_table "messages", force: :cascade do |t|
    t.text     "body",       null: false
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "parent_id"
  end

  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "nickname"
    t.string   "link"
    t.string   "image"
    t.string   "uid",                                 null: false
    t.string   "provider",                            null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "messages", "users"
end
