class User < ActiveRecord::Base
  
  acts_as_authentic do |u|
    u.logged_in_timeout = 20.minutes
  end
  
  belongs_to :role
  belongs_to :client
  has_many :tasks
  has_many :comments
  belongs_to :category
  has_many :evaluations
  belongs_to :company
  has_and_belongs_to_many :projects
  has_many :messages
  has_many :events
  has_and_belongs_to_many :user_groups
  
  validates_presence_of :company, :role
  
  named_scope :by_name , :order=>:name
  named_scope :from_client, lambda{|client_id|  {:conditions=>["client_id = ?", client_id]}}
end
