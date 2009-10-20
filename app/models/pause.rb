class Pause < ActiveRecord::Base
  belongs_to :task
 
  named_scope :from_task, lambda{ |task_id| {:conditions=>["task_id=?",task_id], 
                          :order=>"created_at"} }
  named_scope :minhas, lambda{ |id| {:conditions=>["user_id = ?", id]} }

  def tempo_de_solicitacao
    minutos = ((Time.now - created_at) / 60 ).to_i
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
  
end
