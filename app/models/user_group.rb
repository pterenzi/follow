class UserGroup < ActiveRecord::Base
  has_and_belongs_to_many :users
  named_scope :active, :conditions=>["active='t'"]
  named_scope :from_client, lambda{ |client_id| {:conditions=>["client_id=?",client_id]}}
  named_scope :by_name, :order=>:name
end
