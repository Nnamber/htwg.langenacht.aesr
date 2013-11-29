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

ActiveRecord::Schema.define(version: 20131129141411) do

  create_table "answers", force: true do |t|
    t.string   "notice"
    t.string   "body"
    t.boolean  "correct"
    t.string   "pattern"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", force: true do |t|
    t.string   "topic"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "imports", force: true do |t|
    t.string   "useless"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "xmlfile_file_name"
    t.string   "xmlfile_content_type"
    t.integer  "xmlfile_file_size"
    t.datetime "xmlfile_updated_at"
  end

  create_table "questions", force: true do |t|
    t.string   "questiontype"
    t.string   "name"
    t.string   "body"
    t.string   "noticewrong"
    t.string   "noticeright"
    t.string   "notice"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
