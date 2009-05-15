class Categoria < ActiveRecord::Base
#Relacionamentos

has_many :permissaos, :through=> :categorias_permissaos 

has_many :categorias_permissaos 

#has_many :usuarios

has_many :users



#Validações

validates_length_of  :nome, :maximum=>32, :message=>"não pode exeder os 32 caracteres!"

end
