class Company < ActiveRecord::Base
  
  has_many :users
  
  validates_presence_of :name

  named_scope :active, lambda{ |client_id| {:conditions=>["active=true and client_id=?",client_id]}}
  
end
