class Tarefa < ActiveRecord::Base
#Relacionamentos

belongs_to :projeto

belongs_to :usuario

belongs_to :situacao

belongs_to :solicitante, :class_name => "Usuario", :foreign_key => "solicitante_id"

has_many :comentarios



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

def sem_solicitante
  return solicitante_id.nil?
end

end
