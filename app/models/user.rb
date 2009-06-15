class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :tasks
  has_many :comentarios
  belongs_to :categoria
  has_many :avaliacaos
  has_many :recusas
  
  has_and_belongs_to_many :projects
end
