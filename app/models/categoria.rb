class Categoria < ActiveRecord::Base
  has_many :users

  validates_presence_of :nome
end
