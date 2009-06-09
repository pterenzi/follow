class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :tasks
  has_many :comentarios
  belongs_to :categoria
  has_many :avaliacaos
  has_many :recusas
end
