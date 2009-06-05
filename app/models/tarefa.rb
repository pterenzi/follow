class Tarefa < ActiveRecord::Base

belongs_to :projeto
belongs_to :user
belongs_to :solicitante, :class_name => "User", :foreign_key => "solicitante_id"
has_many :comentarios
has_many :pausas
has_many :avaliacaos

validates_presence_of :projeto_id, :message=>"não pode ficar em branco!"
validates_presence_of :descricao, :message=>"não pode ficar em branco!"
validates_presence_of :tempo_est, :message=>"não pode ficar em branco!"
validates_length_of  :tempo_est, :maximum=>4, :message=>"não pode exeder os 4 caracteres!"
validates_numericality_of  :tempo_est, :message=>"deve ser numérico!"

named_scope :encerradas, :conditions=>{:termino_at => !nil}
named_scope :solicitadas_por, lambda{ |id| {:conditions=>["solicitante_id = ?", id]} }
named_scope :minhas, lambda{ |id| {:conditions=>["user_id = ?", id]} }
named_scope :outra_pessoa, :conditions=>["user_id <> solicitante_id"]
named_scope :de_mim_para_mim, lambda{ |id| {:conditions=>["user_id = solicitante_id and solicitante_id = ?", id]} }    
named_scope :para_mim, lambda{ |id| {:conditions=>["user_id <> solicitante_id and user_id = ?", id]} }    
named_scope :abertas, :conditions=>{:termino_at => nil}
#named_scope :sem_avaliacao,           
#            :joins=>:avaliacaos,          
#            lambda{ |id,user_id| {:conditions=>{"avaliacaos.tarefa_id=? and avaliacaos.user_id=?",id, user_id}} }
named_scope :sem_user, :conditions=>["user_id is null"]
named_scope :com_user, :conditions=>["user_id != '?' ",nil]
named_scope :por_solicitante, :order=>:solicitante_id
named_scope :sem_recusa, :conditions=>["recusada='f'"]

def usuario_que_criou(usuario_id)
  usuario = Usuario.find(usuario_id)
  usuario_id == solicitante_id
  #TODO test unitario para este metodo
end

def tempo_decorrido
  return 1
  avaliacao = Avaliacao.last(:conditions=>["user_id=? and tarefa_id=?", id, user_id])
  return (((Time.now - avaliacao.created_at) / 1.hour).round).to_s + " hora(s). "
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
  pausa = Pausa.find(:all, :conditions=>["pausa_padrao_id is NULL and tarefa_id=?",id]).last
  return (pausa.nil? || (pausa.aceito & !pausa.reinicio.nil?)) 
end

def pausada
  pausa = Pausa.find(:all, :conditions=>["pausa_padrao_id IS NULL and tarefa_id=?",id]).last
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
  pausa = Pausa.find(:all, :conditions=>["pausa_padrao_id IS NULL and tarefa_id=?",id]).last
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
  if tarefas.nil? || tarefas.empty?
    return false
  end
  for tarefa in tarefas
      return true if tarefa.pausada_padrao 
  end
  return false
end

def justificativa_recusa
  avaliacao = Avaliacao.find(:all, :conditions=>["recusada='t' and tarefa_id=? and user_id=?", id, user_id])
  if avaliacao.nil? 
    return ""
  else
    return avaliacao[0].comentario_recusa_user
  end
end

def self.busca_minhas_solicitacoes(solicitante_id)
  resultado = Array.new
  @tarefas = Tarefa.all(:conditions=>["user_id is not null and solicitante_id=?", solicitante_id])
  for tarefa in @tarefas do
    if tarefa.termino_at.nil?
      resultado << tarefa
    else
      a = Avaliacao.last(:conditions=>["nota is null and tarefa_id=?",tarefa.id])
      if !a.nil?
        resultado << tarefa
      end
    end
  end
  return resultado
end

def self.encerradas_sem_avaliacao(solicitante_id)
  resultado = Array.new
  tarefas = Tarefa.all(:conditions=>["termino_at is not null and solicitante_id=?  ",solicitante_id])
  for tarefa in tarefas do
     a = Avaliacao.last(:conditions=>["nota is null and tarefa_id=?",tarefa.id])
      if !a.nil?
        resultado << tarefa
      end
  end
  return resultado
end

end
