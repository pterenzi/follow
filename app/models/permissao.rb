class Permissao < ActiveRecord::Base
#Relacionamentos

has_many :categorias, :through=> :categorias_permissaos 

has_many :categorias_permissaos 



#Validações

validates_length_of  :descricao, :maximum=>64, :message=>"não pode exeder os 64 caracteres!"

end
