class Pausa < ActiveRecord::Base
  belongs_to :tarefa
  
  def self.da_tarefa(tarefa_id)
    @pausa = Pausa.find(:all, :conditions=>["tarefa_id=?",tarefa_id]).last
    return @pausa
  end
  
  def tempo_de_solicitacao
    minutos = ((Time.now - created_at) / 60 ).to_i
    horas = nil
    if minutos > 60
      horas = minutos / 60
    end
    if horas.nil?
       return minutos + " min."
    else
      return horas.to_s + "h e " + (minutos % 60).to_s + " min."
    end
  end
  
end
