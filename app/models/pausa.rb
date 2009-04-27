class Pausa < ActiveRecord::Base
  belongs_to :tarefa
  
  def self.da_tarefa(tarefa_id)
    @pausa = Pausa.find(:all, :conditions=>["tarefa_id=?",tarefa_id]).last
    return @pausa
  end
  
end
