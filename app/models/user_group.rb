class UserGroup < ActiveRecord::Base
  has_and_belongs_to_many :users
  named_scope :active, :conditions=>{:active=>true}
end
