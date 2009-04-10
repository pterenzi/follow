class ProjetosUsuario < ActiveRecord::Base
#Relacionamentos

belongs_to :projeto

belongs_to :usuario



#Validações

validates_presence_of :usuarios_id, :message=>"não pode ficar em branco!"

validates_presence_of :projetos_id, :message=>"não pode ficar em branco!"

end
