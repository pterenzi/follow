class Company < ActiveRecord::Base
  
  has_many :users
  
  validates_presence_of :name
  named_scope :active, :conditions=>{:active=>true}
  
end
