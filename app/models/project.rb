class Project < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :tasks
  named_scope :active, :conditions=>{:active=>true}
end
