class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :tasks
  has_many :comments
  belongs_to :category
  has_many :evaluations
  belongs_to :company
  has_and_belongs_to_many :projects
  has_many :messages
  has_many :events
  has_and_belongs_to_many :user_groups
  
  validates_presence_of :company
#  has_many :written_by,  :foreign_key=>"written_by"
#TODO criar campo prefered language
#TODO criar link para alterar linguagem
end
