class Pause < ActiveRecord::Base
  belongs_to :task
  
  def self.da_task(task_id)
    @pause = Pause.find(:all, :conditions=>["task_id=?",task_id]).last
    return @pause
  end
  
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
