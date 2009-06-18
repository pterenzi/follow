# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090617211237) do

  create_table "evaluations", :force => true do |t|
    t.integer  "task_id"
    t.integer  "user_id"
    t.integer  "grade"
    t.string   "evaluation_comment"
    t.string   "user_comment"
    t.boolean  "refused",               :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name",       :limit => 32
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.string   "description"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.boolean  "active",     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pattern_pauses", :force => true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pauses", :force => true do |t|
    t.datetime "data"
    t.integer  "task_id"
    t.string   "justification"
    t.boolean  "accepted"
    t.string   "comment_requestor"
    t.datetime "restart"
    t.boolean  "pattern"
    t.integer  "pattern_pause_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name",        :limit => 32
    t.string   "description", :limit => 256
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects_users", :force => true do |t|
    t.integer "project_id"
    t.integer "user_id"
  end

  create_table "messages", :force => true do |t|
    t.integer  "escrito_por"
    t.integer  "para"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", :force => true do |t|
    t.integer  "projeto_id"
    t.integer  "user_id"
    t.integer  "requestor_id"
    t.string   "description"
    t.integer  "estimated_time",                      :limit => 4,                    :null => false
    t.boolean  "alerta_usuario",                              :default => false
    t.boolean  "alerta_requestor",                          :default => false
    t.datetime "end_at"
    t.string   "comment_end_user"
    t.string   "comment_end_requestor"
    t.boolean  "refused",                                    :default => false
    t.boolean  "tem_comment",                              :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login",                            :null => false
    t.string   "crypted_password",                 :null => false
    t.string   "password_salt",                    :null => false
    t.string   "persistence_token",                :null => false
    t.integer  "login_count",       :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.integer  "categories_id"
    t.string   "name"
    t.integer  "company_id"
  end

  add_index "users", ["company_id"], :name => "index_users_on_company_id"
  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

end
