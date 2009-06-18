class Evaluation < ActiveRecord::Base
  
#  set_table_name "evaluation"
  
  belongs_to :task
  belongs_to :user
end
