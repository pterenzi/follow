class Recusa < ActiveRecord::Base
  belongs_to :tarefa
  belongs_to :user
end
