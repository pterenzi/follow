class Projeto < ActiveRecord::Base
#Relacionamentos

has_many :empresas, :through=> :empresas_projetos 

has_many :empresas_projetos 

has_many :usuarios, :through=> :projetos_usuarios 

has_many :projetos_usuarios 

belongs_to :task



#Validações

validates_length_of  :nome, :maximum=>32, :message=>"não pode exeder os 32 caracteres!"

validates_presence_of :descricao, :message=>'não pode estar em branco!'

validates_length_of  :descricao, :maximum=>256, :message=>"não pode exeder os 256 caracteres!"

validates_length_of  :prazo, :maximum=>4, :message=>"não pode exeder os 4 caracteres!"

validates_numericality_of  :prazo, :message=>"deve ser numérico!"

end
