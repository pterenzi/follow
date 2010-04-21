class Pause < ActiveRecord::Base
  belongs_to :task
 
  named_scope :from_task, lambda{ |task_id| {:conditions=>["task_id=?",task_id], 
                          :order=>"created_at"} }
  named_scope :minhas, lambda{ |id| {:conditions=>["user_id = ?", id]} }

  named_scope :from_an_user_in_a_task, lambda{ |task_id,user_id| {
      :conditions=>["task_id=? and user_id = ?", task_id, user_id]} } 

  named_scope :accepted , lambda{|client_id| {:conditions=>["accepted='t' and client_id=?", client_id]}}
    
    
  def tempo_de_solicitacao
    minutos = ((Time.current - created_at) / 60 ).to_i
    horas = nil
    if minutos > 60
      horas = minutos / 60
    end
    if horas.nil?
       return minutos.to_s + " min."
    else
      return horas.to_s + "h e " + (minutos % 60).to_s + " min."
    end
  end
  
  def duration_in_minutes
    (restart - created_at) / 60
  end
  
end
