class Empresa < ActiveRecord::Base
#Relacionamentos

has_many :projetos, :through=> :empresas_projetos 

has_many :empresas_projetos 



#Validações

validates_length_of  :nome, :maximum=>64, :message=>"não pode exeder os 64 caracteres!"

validates_length_of  :razao, :maximum=>128, :message=>"não pode exeder os 128 caracteres!"

validates_length_of  :tipo, :maximum=>4, :message=>"não pode exeder os 4 caracteres!"

validates_numericality_of  :tipo, :message=>"deve ser numérico!"

validates_length_of  :contato, :maximum=>64, :message=>"não pode exeder os 64 caracteres!"

validates_length_of  :contato_fone, :maximum=>32, :message=>"não pode exeder os 32 caracteres!"

validates_length_of  :contato_cell, :maximum=>32, :message=>"não pode exeder os 32 caracteres!"

validates_length_of  :contato_email, :maximum=>128, :message=>"não pode exeder os 128 caracteres!"

validates_length_of  :fone, :maximum=>32, :message=>"não pode exeder os 32 caracteres!"

validates_length_of  :endereco, :maximum=>128, :message=>"não pode exeder os 128 caracteres!"

validates_length_of  :bairro, :maximum=>32, :message=>"não pode exeder os 32 caracteres!"

validates_length_of  :municipio, :maximum=>32, :message=>"não pode exeder os 32 caracteres!"

validates_length_of  :uf, :maximum=>2, :message=>"não pode exeder os 2 caracteres!"

validates_length_of  :cnpj, :maximum=>32, :message=>"não pode exeder os 32 caracteres!"

validates_length_of  :insc_est, :maximum=>64, :message=>"não pode exeder os 64 caracteres!"

validates_length_of  :insc_mun, :maximum=>64, :message=>"não pode exeder os 64 caracteres!"

validates_length_of  :site, :maximum=>128, :message=>"não pode exeder os 128 caracteres!"

validates_length_of  :banco, :maximum=>32, :message=>"não pode exeder os 32 caracteres!"

validates_length_of  :agencia, :maximum=>32, :message=>"não pode exeder os 32 caracteres!"

validates_length_of  :conta, :maximum=>32, :message=>"não pode exeder os 32 caracteres!"

end
