class Tarefa < ActiveRecord::Base
#Relacionamentos

belongs_to :projeto

belongs_to :usuario

belongs_to :situacao



#Validações

validates_presence_of :projeto_id, :message=>"não pode ficar em branco!"

validates_presence_of :usuario_id, :message=>"não pode ficar em branco!"

validates_presence_of :tempo_est, :message=>"não pode ficar em branco!"

validates_length_of  :tempo_est, :maximum=>4, :message=>"não pode exeder os 4 caracteres!"

validates_numericality_of  :tempo_est, :message=>"deve ser numérico!"

validates_presence_of :avaliacao, :message=>"não pode ficar em branco!"

validates_length_of  :avaliacao, :maximum=>4, :message=>"não pode exeder os 4 caracteres!"

validates_numericality_of  :avaliacao, :message=>"deve ser numérico!"

validates_presence_of :situacao_id, :message=>"não pode ficar em branco!"

end
