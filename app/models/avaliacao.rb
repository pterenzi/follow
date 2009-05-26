class Avaliacao < ActiveRecord::Base
  
  set_table_name "avaliacao"
  
  belongs_to :tarefa
  belongs_to :user
end
