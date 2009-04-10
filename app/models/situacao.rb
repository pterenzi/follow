class Situacao < ActiveRecord::Base
#Relacionamentos

belongs_to :tarefa



#Validações

validates_length_of  :descricao, :maximum=>32, :message=>"não pode exeder os 32 caracteres!"

validates_length_of  :sigla, :maximum=>8, :message=>"não pode exeder os 8 caracteres!"

end
