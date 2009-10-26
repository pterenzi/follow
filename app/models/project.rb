class Project < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :tasks
  named_scope :active, lambda{ |client_id| {:conditions=>["active=true and client_id=?", client_id]}}
end
