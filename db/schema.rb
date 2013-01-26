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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130125224328) do

  create_table "match_scores", :force => true do |t|
    t.integer  "match_id"
    t.integer  "team_id"
    t.integer  "goals"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "win"
  end

  create_table "matches", :force => true do |t|
    t.boolean  "crawling"
    t.date     "date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teams", :force => true do |t|
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "number_of_wins",  :default => 0
    t.integer  "number_of_loses", :default => 0
    t.float    "quote",           :default => 0.0
    t.integer  "number_of_games", :default => 0
  end

  create_table "teams_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "team_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "image"
    t.integer  "quote",      :default => 1200
    t.integer  "ranking",    :default => 0
  end

end
