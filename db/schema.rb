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

ActiveRecord::Schema.define(:version => 20260218165401) do

  create_table "Reportetotal", :id => false, :force => true do |t|
    t.integer  "id",                               :default => 0, :null => false
    t.integer  "folio"
    t.string   "department"
    t.string   "Solicitante",       :limit => 511
    t.string   "email_solicitante"
    t.string   "Tecnico",           :limit => 511
    t.string   "email_tecnico"
    t.string   "category"
    t.text     "description"
    t.string   "status"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.datetime "taked_at"
    t.datetime "ended_at"
    t.text     "revision"
    t.datetime "ideal_time"
    t.string   "client_status"
    t.text     "revision_old"
  end

  create_table "assignations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "department"
    t.integer  "technician_id"
  end

  create_table "assignments", :force => true do |t|
    t.integer  "ticket_id"
    t.integer  "technician_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "department"
  end

  create_table "reporteASIF", :id => false, :force => true do |t|
    t.integer  "id",          :default => 0, :null => false
    t.integer  "folio"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "category"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "status"
    t.string   "department"
    t.datetime "taked_at"
    t.datetime "ended_at"
    t.text     "revision"
    t.text     "description"
  end

  create_table "scores", :force => true do |t|
    t.text     "content"
    t.integer  "score"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "ticket_id"
    t.integer  "user_id"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "technicians", :force => true do |t|
    t.string   "email"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "category"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tickets", :force => true do |t|
    t.integer  "user_id"
    t.text     "description"
    t.string   "category"
    t.string   "priority"
    t.string   "technician"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "status"
    t.string   "department"
    t.datetime "taked_at"
    t.datetime "ended_at"
    t.text     "revision"
    t.datetime "ideal_time"
    t.string   "client_status"
    t.text     "tech_team"
    t.text     "revision_old"
    t.integer  "folio"
    t.string   "ext"
    t.string   "location"
    t.time     "schedule_time"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "category"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.integer  "tech"
    t.string   "login"
  end

end
