class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :tarefas
  
  has_many :comentarios
  
  belongs_to :categoria
  has_many :avaliacaos
end
