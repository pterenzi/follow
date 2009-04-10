class EmpresasProjeto < ActiveRecord::Base
#Relacionamentos

belongs_to :empresa

belongs_to :projeto



#Validações

validates_presence_of :empresas_id, :message=>"não pode ficar em branco!"

validates_presence_of :projetos_id, :message=>"não pode ficar em branco!"

validates_length_of  :nome, :maximum=>64, :message=>"não pode exeder os 64 caracteres!"

end
