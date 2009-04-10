class Recado < ActiveRecord::Base
#Relacionamentos

belongs_to :usuario



#Validações

validates_presence_of :usuarios_id, :message=>"não pode ficar em branco!"

end
