class Task < ActiveRecord::Base

belongs_to :project
belongs_to :user
belongs_to :requestor, :class_name => "User", :foreign_key => "requestor_id"
has_many :comments
has_many :pauses
has_many :evaluations

validates_presence_of :project_id, :message=>"não pode ficar em branco!"
validates_presence_of :description, :message=>"não pode ficar em branco!"
validates_presence_of :estimated_time, :message=>"não pode ficar em branco!"
validates_length_of  :estimated_time, :maximum=>4, :message=>"não pode exeder os 4 caracteres!"
validates_numericality_of  :estimated_time, :message=>"deve ser numérico!"

named_scope :ordenados, :order=>:id
named_scope :encerradas, :conditions=>{:end_at => !nil}
named_scope :solicitadas_por, lambda{ |id| {:conditions=>["requestor_id = ?", id]} }
named_scope :minhas, lambda{ |id| {:conditions=>["user_id = ?", id]} }
named_scope :outra_pessoa, :conditions=>["user_id <> requestor_id"]
named_scope :de_mim_para_mim, lambda{ |id| {:conditions=>["user_id = requestor_id and requestor_id = ?", id]} }    
named_scope :para_mim, lambda{ |id| {:conditions=>["user_id <> requestor_id and user_id = ?", id]}}
named_scope :abertas, :conditions=>{:end_at => nil}
#named_scope :sem_evaluation,           
#            :joins=>:evaluations,          
#            lambda{ |id,user_id| {:conditions=>{"evaluations.task_id=? and evaluations.user_id=?",id, user_id}} }
named_scope :sem_user, :conditions=>["user_id is null"]
named_scope :com_user, :conditions=>["user_id != '?' ",nil]
named_scope :por_requestor, :order=>:requestor_id
named_scope :sem_recusa, :conditions=>["refused='f'"]

def usuario_que_criou(usuario_id)
  usuario = Usuario.find(usuario_id)
  usuario_id == requestor_id
  #TODO test unitario para este metodo
end

def tempo_decorrido
  return 1
  evaluation = Evaluation.last(:conditions=>["user_id=? and task_id=?", id, user_id])
  return (((Time.now - evaluation.created_at) / 1.hour).round).to_s + " hora(s). "
end

def sem_usuario
  return usuario_id.nil?
end

def status
  return "em pause padrão" if paused_pattern
  return "sem pause" if sem_pause
  return "paused" if paused
  return "pause não autorizada" if pause_nao_aceita
  return "paused esperando aprovação" if paused_esperando_aprovacao
  return "em andamento"
  end

def sem_pause
  pause = Pause.find(:all, :conditions=>["pattern_pause_id is NULL and task_id=?",id]).last
  return (pause.nil? || (pause.accepted & !pause.restart.nil?)) 
end

def paused
  pause = Pause.find(:all, :conditions=>["pattern_pause_id IS NULL and task_id=?",id]).last
  if pause.nil?
    return false
  else
    return pause.accepted==true & pause.restart.nil?
  end
end

def pause_nao_aceita
  pause = Pause.da_task(id)
  if pause.nil? 
    return false
  else
    if pause.accepted.nil?
      return false
    else
      return !pause.accepted
    end
  end
end

def paused_esperando_aprovacao
  pause = Pause.find(:all, :conditions=>["pattern_pause_id IS NULL and task_id=?",id]).last
  if pause.nil?
    return false
  else
    return pause.accepted.nil?
  end
end

def paused_pattern
  pause = Pause.find(:all, :conditions=>[" task_id=? and pattern_pause_id not null and restart is null",id]).last
  return !pause.nil?
end

def terminada_sem_comment_do_requestor
  return !end_at.nil? & comment_end_requestor.nil?
end

def self.tem_task_com_pattern_pause(tasks)
  if tasks.nil? || tasks.empty?
    return false
  end
  for task in tasks
      return true if task.paused_pattern 
  end
  return false
end

def justification_recusa
  evaluation = Evaluation.last( :conditions=>["refused='t' and task_id=? and user_id=?", id, user_id])
  if evaluation.nil? 
    return ""
  else
    return evaluation.evaluation_comment
  end
end

def self.busca_my_requests(requestor_id)
  resultado = Array.new
  @tasks = Task.all(:order=>"user_id", :conditions=>["user_id is not null and requestor_id <> user_id and requestor_id=?", requestor_id])
  for task in @tasks do
    if (task.end_at.nil?) or (!task.end_at.nil? and task.comment_end_requestor.nil?)
      resultado << task
    else
      a = Evaluation.last(:conditions=>["grade is null and task_id=?",task.id])
      if !a.nil?
        resultado << task
      end
    end
  end
  return resultado
end

def self.encerradas_sem_evaluation(requestor_id)
  resultado = Array.new
  tasks = Task.all(:conditions=>["end_at is not null and requestor_id=?  ",requestor_id])
  for task in tasks do
     a = Evaluation.last(:conditions=>["grade is null and task_id=?",task.id])
      if !a.nil?
        resultado << task
      end
  end
  return resultado
end

def self.recent_task(current_user)
  Task.first(:order=>"created_at desc", :conditions=>["user_id=? ", current_user])
end

end
