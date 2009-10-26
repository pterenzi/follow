class UserGroup < ActiveRecord::Base
  has_and_belongs_to_many :users
  named_scope :active, lambda{ |client_id| {:conditions=>["active=true and client_id=?",client_id]}}
end
