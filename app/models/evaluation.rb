class Evaluation < ActiveRecord::Base
  
#  set_table_name "evaluation"
  
  belongs_to :task
  belongs_to :user
  
  named_scope :sem_avaliacao, :conditions=>["evaluation_comment ISNULL"]
end
