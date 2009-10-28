class Project < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :tasks
  named_scope :active, :conditions=>["active='t'"]
  named_scope :by_name, :order=>:name
  named_scope :from_client, lambda{ |client_id| {:conditions=>["active='t' and client_id=?", client_id]}}
end
