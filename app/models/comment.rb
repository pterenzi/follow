class Comment < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
#  validates_presence_of :usuario_id
  validates_presence_of :description
end
