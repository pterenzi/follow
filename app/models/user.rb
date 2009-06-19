class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :tasks
  has_many :comments
  belongs_to :category
  has_many :evaluations
  has_many :recusas
  belongs_to :company
  has_and_belongs_to_many :projects
end
