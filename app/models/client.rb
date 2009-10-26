class Client < ActiveRecord::Base
  validates_numericality_of :users_license
  validates_presence_of :name
  
  has_many :users
  has_many :categories
 
  def license_full
    users.size >= users_license
  end
  
  def available_license
    users_license - users.size
  end
  
end
