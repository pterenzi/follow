class Avaliacao < ActiveRecord::Base
  
#  set_table_name "avaliacao"
  
  belongs_to :task
  belongs_to :user
end
