class Task < ActiveRecord::Base

belongs_to :project
belongs_to :user
belongs_to :requestor, :class_name => "User", :foreign_key => "requestor_id"
has_many :comments, :include=>[:user]
has_many :pauses
has_many :evaluations

validates_presence_of :description, :message=>"não pode ficar em branco!"
validates_presence_of :estimated_time, :message=>"não pode ficar em branco!"
validates_length_of  :estimated_time, :maximum=>4, :message=>"não pode exeder os 4 caracteres!"
validates_numericality_of  :estimated_time, :message=>"deve ser numérico!"

named_scope :from_client, lambda {| client_id| {:conditions=>["client_id=?", client_id]}}
named_scope :abertas, :conditions=>["start_at <= ? and end_at IS NULL",(Time.now+1.minute).strftime("%Y-%m-%d %H:%M") ], 
                :include=>[:project]
named_scope :for_user, lambda{ |user_id| {:conditions=>["user_id = '?' ",user_id]}}
named_scope :de_mim_para_mim, lambda{ |id| {:conditions=>["tasks.user_id = tasks.requestor_id and tasks.requestor_id = ?", id]} }    
named_scope :encerradas, :conditions=>["NOT end_at ISNULL"]
named_scope :minhas, lambda{ |id| {:conditions=>["user_id = ?", id]} }
named_scope :not_mines, lambda{ |id| {:conditions=>["user_id <> ?", id]} }
named_scope :ordenados, :order=>:id, :include=>[:comments]
named_scope :outra_pessoa, :conditions=>["user_id <> requestor_id"]
named_scope :para_mim, lambda{ |id| {:conditions=>["tasks.user_id <> tasks.requestor_id and tasks.user_id = ?", id]}}
named_scope :por_requestor, :order=>:requestor_id , :include=>[:requestor]
named_scope :solicitadas_por, lambda{ |id| {:conditions=>["requestor_id = ?", id], :include=>[:user,:requestor, :comments]} }
#TODO fazer este lambda. Talvez fazer método ao invez de named_scope. Parece que 
   # sem_evluation vem com com_evaluation 
named_scope :sem_evaluation  , lambda {|task_id, user_id| {
            :joins => ["INNER JOIN evaluations ON evaluations.task_id = tasks.id"],
            :conditions=>["evaluations.task_id=? and evaluations.user_id=? and grade ISNULL",task_id, user_id]}}
named_scope :sem_recusa, :conditions=>["refused='f'"]
named_scope :sem_user, :conditions=>["user_id is null"]
named_scope :with_user_defined, :conditions=>["user_id NOT NULL"]

def usuario_que_criou(user_id)
  user = User.find(user_id)
  user_id == requestor_id
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
  return "encerrada aguardando avaliação" if terminada_sem_comment_do_requestor
  return "encerrada" if finished
  return "em pause padrão" if paused_pattern
  return "sem pause" if sem_pause
  return "paused" if paused
  return "pause não autorizada" if pause_nao_aceita
  return "pausada, esperando aprovação" if paused_esperando_aprovacao
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
  pause = Pause.from_task(id)
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
  evaluation = Evaluation.last(:conditions=>["task_id = ?", id])
  return !end_at.nil? & evaluation.comment.nil?
end

def finished_and_evaluated
  evaluation = Evaluation.last(:conditions=>["task_id = ?", id])
  return !end_at.nil? & !evaluation.grade.nil?
end

def finished
  return !end_at.nil? 
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
    return evaluation.comment
  end
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
  Task.first(:order=>"start_at desc", :conditions=>["start_at < ?  and user_id=? ", Time.now.strftime("%Y-%m-%d %H:%M") ,current_user])
end

  def grade
    if finished_and_evaluated
       evaluation = Evaluation.last(:conditions=>["task_id = ?", id])
       return evaluation.grade
    else
      return "---"
    end
  end

  def info
    result = "Description : " + description + "<br/>"
    result += "requested by :" + requestor.name  + " at " + start_at.strftime("%x") + "  " + start_at.strftime("%H:%M") + "<br/>"
    users.each do |user|
      evaluation = Evaluation.from_user(id,user.id)
      result += " user : " + user.name + "<br/> grade : " + evaluation.first.grade.to_s + 
          " <br/>comment : " + evaluation.first.comment + "<br/>"
    end
    result += "end at : " + end_at.strftime("%x") + "  " + end_at.strftime("%H:%M")  + "<br/>"
    result += " estimated time : " + estimated_time.to_s + "<br/>"
    result += " duration : " + duration_in_hours + "<br/>" 
    result
  end
  
  def users
    evaluations = Evaluation.all(:conditions=>["task_id = ?",id])
    list = []
    evaluations.each do |eval| 
      list << eval.user
    end 
    list
  end

  def duration
    total = 0
    total_pause = 0
    users.each do |user|
      pauses = Pause.from_an_user_in_a_task(id,user.id)
      pauses.each do |pause|
        total_pause += pause.duration_in_minutes
      end
    end
    if end_at.nil?
      total = Time.now - start_at - total_pause
    else
      total = end_at - start_at - total_pause.minutes
    end
  end
  
  def duration_in_hours
    hour = duration / 3600
    (duration / 3600).to_i.to_s + ":" + ((hour - hour.to_i) * 60).to_i.to_s
  end
  
  def in_time
    duration < (estimated_time * 3600)  
  end
  
  def delayed
    in_time==false
  end
end
