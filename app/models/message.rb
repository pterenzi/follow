class Message < ActiveRecord::Base
#Relacionamentos

#belongs_to :usuario
belongs_to :written_by, :class_name => "User", :foreign_key => "written_by"
belongs_to :written_to, :class_name => "User", :foreign_key => "written_to"
#TODO fazser todo o processamento de messages


#Validações


end
