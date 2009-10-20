class Evaluation < ActiveRecord::Base
  
#  set_table_name "evaluation"
  
  belongs_to :task
  belongs_to :user
  
  named_scope :sem_avaliacao, :conditions=>["comment ISNULL"]
  named_scope :from_user,lambda{
    |task_id, user_id| { :conditions=>["task_id = ? and user_id=?", task_id, user_id]} }
end
