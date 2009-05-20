class Tarefa < ActiveRecord::Base
#Relacionamentos

belongs_to :projeto

#belongs_to :usuario
belongs_to :user

belongs_to :situacao

#belongs_to :solicitante, :class_name => "Usuario", :foreign_key => "solicitante_id"
belongs_to :solicitante, :class_name => "User", :foreign_key => "solicitante_id"

has_many :comentarios

has_many :pausas



#Validações

validates_presence_of :projeto_id, :message=>"não pode ficar em branco!"

#validates_presence_of :usuario_id, :message=>"não pode ficar em branco!"

validates_presence_of :descricao, :message=>"não pode ficar em branco!"

validates_presence_of :tempo_est, :message=>"não pode ficar em branco!"

validates_presence_of :descricao, :message=>"não pode ficar em branco!"

validates_length_of  :tempo_est, :maximum=>4, :message=>"não pode exeder os 4 caracteres!"

validates_numericality_of  :tempo_est, :message=>"deve ser numérico!"

#validates_presence_of :avaliacao, :message=>"não pode ficar em branco!"

validates_length_of  :avaliacao, :maximum=>4, :message=>"não pode exeder os 4 caracteres!", :allow_nil=>true

validates_numericality_of  :avaliacao, :message=>"deve ser numérico!", :allow_nil=>true

validates_presence_of :situacao_id, :message=>"não pode ficar em branco!"

def usuario_que_criou(usuario_id)
  usuario = Usuario.find(usuario_id)
  usuario_id == solicitante_id
  #TODO test unitario para este metodo
end

def sem_usuario
  return usuario_id.nil?
end

def status
  return "em pausa padrão" if pausada_padrao
  return "sem pausa" if sem_pausa
  return "pausada" if pausada
  return "pausa não autorizada" if pausa_nao_aceita
  return "pausada esperando aprovação" if pausada_esperando_aprovacao
  return "em andamento"
  end

def sem_pausa
  pausa = Pausa.find(:all, :conditions=>["pausa_padrao_id=NULL and tarefa_id=?",id]).last
  return (pausa.nil? || (pausa.aceito & !pausa.reinicio.nil?)) || (pausa.aceito)
end

def pausada
  pausa = Pausa.find(:all, :conditions=>["pausa_padrao_id=NULL and tarefa_id=?",id]).last
  if pausa.nil?
    return false
  else
    return pausa.aceito==true & pausa.reinicio.nil?
  end
end

def pausa_nao_aceita
  pausa = Pausa.da_tarefa(id)
  if pausa.nil? 
    return false
  else
    if pausa.aceito.nil?
      return false
    else
      return !pausa.aceito
    end
  end
end

def pausada_esperando_aprovacao
  pausa = Pausa.find(:all, :conditions=>["pausa_padrao_id=NULL and tarefa_id=?",id]).last
  if pausa.nil?
    return false
  else
    return pausa.aceito.nil?
  end
end

def pausada_padrao
  pausa = Pausa.find(:all, :conditions=>[" tarefa_id=? and pausa_padrao_id not null and reinicio is null",id]).last
  return !pausa.nil?
end

def terminada_sem_comentario_do_solicitante
  return !termino_at.nil? & comentario_termino_solicitante.nil?
end

def self.tem_tarefa_com_pausa_padrao(tarefas)
  for tarefa in tarefas
      return true if tarefa.pausada_padrao 
  end
  return false
end

end
