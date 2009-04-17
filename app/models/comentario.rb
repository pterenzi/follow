class Comentario < ActiveRecord::Base
  belongs_to :tarefa
  belongs_to :usuario
  validates_presence_of :usuario_id
  validates_presence_of :descricao
end
