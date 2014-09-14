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

ActiveRecord::Schema.define(version: 20140913195348) do

  create_table "achievements", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "code_modules", force: true do |t|
    t.integer  "group_id"
    t.string   "name"
    t.string   "icon"
    t.text     "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "comments", force: true do |t|
    t.integer  "post_id"
    t.integer  "commenter_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "proposal_id"
    t.integer  "comment_id"
    t.integer  "module_id"
    t.integer  "share_id"
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id"

  create_table "connections", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "connections", ["followed_id"], name: "index_connections_on_followed_id"
  add_index "connections", ["follower_id", "followed_id"], name: "index_connections_on_follower_id_and_followed_id", unique: true
  add_index "connections", ["follower_id"], name: "index_connections_on_follower_id"

  create_table "federations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "folders", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "description"
    t.string   "icon"
    t.boolean  "private"
    t.integer  "federation_id"
  end

  create_table "hashtags", force: true do |t|
    t.integer  "post_id"
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "comment_id"
  end

  create_table "members", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
    t.integer  "user_id"
    t.integer  "folder_id"
  end

  create_table "messages", force: true do |t|
    t.integer  "receiver"
    t.boolean  "seen",                   default: false
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "folder_id"
    t.binary   "salt",       limit: 255
  end

  create_table "notifications", force: true do |t|
    t.string   "message"
    t.boolean  "checked",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "other_user"
    t.string   "action"
    t.integer  "item"
  end

  create_table "posts", force: true do |t|
    t.integer  "user_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.integer  "original"
    t.integer  "group_id"
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "proposals", force: true do |t|
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "icon"
    t.string   "action"
    t.integer  "user_id"
    t.boolean  "inactive"
    t.text     "submission"
    t.boolean  "anonymous"
    t.string   "module_name"
    t.integer  "federation_id"
  end

  create_table "shares", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.boolean  "good"
    t.boolean  "service"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
    t.string   "image"
    t.integer  "federation_id"
    t.boolean  "open"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "password"
    t.string   "email"
    t.text     "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salt"
    t.string   "profile_picture"
    t.boolean  "anon"
  end

  add_index "users", ["name", "password"], name: "index_users_on_name_and_password", unique: true
  add_index "users", ["name"], name: "index_users_on_name"
  add_index "users", ["password"], name: "index_users_on_password"

  create_table "votes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "up"
    t.boolean  "down"
    t.integer  "voter"
    t.integer  "post_id"
    t.integer  "comment_id"
    t.integer  "proposal_id"
    t.integer  "share_id"
  end

end
