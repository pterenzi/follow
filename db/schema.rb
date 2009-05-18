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

ActiveRecord::Schema.define(:version => 20090513141651) do

  create_table "acoes", :force => true do |t|
    t.string  "nome",        :limit => 20
    t.boolean "funcionando"
  end

  create_table "andamentos", :force => true do |t|
    t.string   "nome"
    t.boolean  "ativo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categorias", :force => true do |t|
    t.string "nome", :limit => 32
  end

  create_table "categorias_permissaos", :force => true do |t|
    t.integer "categorias_id"
    t.integer "permissaos_id"
  end

  create_table "comentarios", :force => true do |t|
    t.integer  "usuario_id"
    t.string   "descricao"
    t.integer  "tarefa_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "empresas", :force => true do |t|
    t.string  "nome",          :limit => 64
    t.string  "razao",         :limit => 128
    t.integer "tipo",          :limit => 4
    t.string  "contato",       :limit => 64
    t.string  "contato_fone",  :limit => 32
    t.string  "contato_cell",  :limit => 32
    t.string  "contato_email", :limit => 128
    t.string  "fone",          :limit => 32
    t.string  "endereco",      :limit => 128
    t.string  "bairro",        :limit => 32
    t.string  "municipio",     :limit => 32
    t.string  "uf",            :limit => 2
    t.string  "cnpj",          :limit => 32
    t.string  "insc_est",      :limit => 64
    t.string  "insc_mun",      :limit => 64
    t.string  "site",          :limit => 128
    t.string  "banco",         :limit => 32
    t.string  "agencia",       :limit => 32
    t.string  "conta",         :limit => 32
  end

  create_table "empresas_projetos", :force => true do |t|
    t.integer "empresas_id"
    t.integer "projetos_id"
    t.string  "nome",        :limit => 64
  end

  create_table "estados", :force => true do |t|
    t.string "sigla",  :limit => 2
    t.string "estado", :limit => 64
  end

  create_table "pausa_padraos", :force => true do |t|
    t.string   "descricao"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pausas", :force => true do |t|
    t.datetime "data"
    t.integer  "tarefa_id"
    t.string   "justificativa"
    t.boolean  "aceito"
    t.string   "comentario_solicitante"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "reinicio"
    t.boolean  "padrao"
    t.integer  "pausa_padrao_id"
  end

  create_table "permissaos", :force => true do |t|
    t.string "descricao", :limit => 64
  end

  create_table "projetos", :force => true do |t|
    t.string  "nome",        :limit => 32
    t.string  "descricao",   :limit => 256
    t.date    "data_inicio"
    t.date    "data_fim"
    t.integer "prazo",       :limit => 4
    t.boolean "ativo",       :limit => 1
  end

  create_table "projetos_usuarios", :force => true do |t|
    t.integer "usuarios_id"
    t.integer "projetos_id"
  end

  create_table "recados", :force => true do |t|
    t.integer "usuarios_id"
  end

  create_table "situacaos", :force => true do |t|
    t.string "descricao", :limit => 32
  end

# Could not dump table "tarefas" because of following StandardError
#   Unknown type 'solicitante_id' for column 'usuario_id'

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
    t.integer  "categoria_id"
  end

  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

  create_table "usuarios", :force => true do |t|
    t.string  "nome",            :limit => 32
    t.string  "cargo",           :limit => 32
    t.string  "pass",            :limit => 64
    t.string  "endereco",        :limit => 128
    t.string  "bairro",          :limit => 32
    t.string  "municipio",       :limit => 32
    t.string  "uf",              :limit => 2
    t.string  "cpf",             :limit => 32
    t.string  "email",           :limit => 128
    t.string  "gerente",         :limit => 32
    t.string  "login",           :limit => 16
    t.string  "hashed_password"
    t.string  "salt"
    t.integer "categoria_id"
  end

end
