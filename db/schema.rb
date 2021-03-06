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

ActiveRecord::Schema.define(:version => 20091027142913) do

  create_table "categories", :force => true do |t|
    t.integer  "client_id"
    t.string   "name",       :limit => 32
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["client_id"], :name => "index_categories_on_client_id"
  add_index "categories", ["id"], :name => "index_categories_on_id"

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.date     "start_at"
    t.boolean  "active"
    t.date     "valid_until"
    t.integer  "users_license"
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

  add_index "comments", ["id"], :name => "index_comments_on_id"
  add_index "comments", ["task_id"], :name => "index_comments_on_task_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.boolean  "active",     :default => true
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies", ["client_id"], :name => "index_companies_on_client_id"
  add_index "companies", ["id"], :name => "index_companies_on_id"

  create_table "evaluations", :force => true do |t|
    t.integer  "task_id"
    t.integer  "user_id"
    t.integer  "grade"
    t.string   "comment"
    t.string   "user_comment"
    t.boolean  "refused",      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "evaluations", ["task_id"], :name => "index_evaluations_on_task_id"
  add_index "evaluations", ["user_id"], :name => "index_evaluations_on_user_id"

  create_table "events", :force => true do |t|
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "event_type"
    t.string   "content"
    t.integer  "user_id"
    t.integer  "written_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["id"], :name => "index_events_on_id"
  add_index "events", ["user_id"], :name => "index_events_on_user_id"

  create_table "messages", :force => true do |t|
    t.string   "content"
    t.datetime "readed"
    t.integer  "written_by"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["id"], :name => "index_messages_on_id"
  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"
  add_index "messages", ["written_by"], :name => "index_messages_on_written_by"

  create_table "pattern_pauses", :force => true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pattern_pauses", ["id"], :name => "index_pattern_pauses_on_id"

  create_table "pauses", :force => true do |t|
    t.datetime "date"
    t.integer  "task_id"
    t.string   "justification"
    t.boolean  "accepted"
    t.string   "comment_requestor"
    t.datetime "restart"
    t.boolean  "pattern"
    t.integer  "pattern_pause_id"
    t.integer  "user_id"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pauses", ["client_id"], :name => "index_pauses_on_client_id"
  add_index "pauses", ["id"], :name => "index_pauses_on_id"
  add_index "pauses", ["task_id"], :name => "index_pauses_on_task_id"

  create_table "projects", :force => true do |t|
    t.string   "name",        :limit => 32
    t.string   "description", :limit => 256
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_id"
  end

  add_index "projects", ["client_id"], :name => "index_projects_on_client_id"
  add_index "projects", ["id"], :name => "index_projects_on_id"

  create_table "projects_users", :id => false, :force => true do |t|
    t.integer "project_id"
    t.integer "user_id"
  end

  add_index "projects_users", ["project_id", "user_id"], :name => "index_projects_users_on_project_id_and_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["id"], :name => "index_roles_on_id"

  create_table "tasks", :force => true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "requestor_id"
    t.string   "description"
    t.integer  "estimated_time",        :limit => 4,                    :null => false
    t.boolean  "user_alert",                         :default => false
    t.boolean  "requestor_alert",                    :default => false
    t.datetime "end_at"
    t.string   "comment_end_user"
    t.string   "comment_end_requestor"
    t.boolean  "refused",                            :default => false
    t.boolean  "has_comment",                        :default => false
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_at"
  end

  add_index "tasks", ["client_id"], :name => "index_tasks_on_client_id"
  add_index "tasks", ["id"], :name => "index_tasks_on_id"
  add_index "tasks", ["project_id"], :name => "index_tasks_on_project_id"
  add_index "tasks", ["requestor_id"], :name => "index_tasks_on_requestor_id"
  add_index "tasks", ["user_id"], :name => "index_tasks_on_user_id"

  create_table "user_groups", :force => true do |t|
    t.string   "name"
    t.boolean  "active"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_groups", ["client_id"], :name => "index_user_groups_on_client_id"
  add_index "user_groups", ["id"], :name => "index_user_groups_on_id"

  create_table "user_groups_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "user_group_id"
  end

  add_index "user_groups_users", ["user_group_id", "user_id"], :name => "index_user_groups_users_on_user_group_id_and_user_id"

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login",                             :null => false
    t.string   "crypted_password",                  :null => false
    t.string   "password_salt",                     :null => false
    t.string   "persistence_token",                 :null => false
    t.integer  "login_count",        :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.integer  "category_id"
    t.string   "name"
    t.string   "email"
    t.integer  "client_id"
    t.integer  "company_id"
    t.string   "preferred_language"
    t.integer  "role_id"
  end

  add_index "users", ["category_id"], :name => "index_users_on_category_id"
  add_index "users", ["client_id"], :name => "index_users_on_client_id"
  add_index "users", ["company_id"], :name => "index_users_on_company_id"
  add_index "users", ["id"], :name => "index_users_on_id"
  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

end
