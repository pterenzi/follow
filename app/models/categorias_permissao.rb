class CategoriasPermissao < ActiveRecord::Base
#Relacionamentos

belongs_to :categoria

belongs_to :permissao



#Validações

validates_presence_of :categoria_id, :message=>"não pode ficar em branco!"

validates_presence_of :permissaos_id, :message=>"não pode ficar em branco!"

end
