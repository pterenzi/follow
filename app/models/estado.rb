class Estado < ActiveRecord::Base
#Relacionamentos



#Validações

validates_length_of  :sigla, :maximum=>2, :message=>"não pode exeder os 2 caracteres!"

validates_length_of  :estado, :maximum=>64, :message=>"não pode exeder os 64 caracteres!"

end
