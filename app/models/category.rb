class Category < ActiveRecord::Base

  has_many :users
  belongs_to :client
  validates_presence_of :name
  validates_uniqueness_of :name
  named_scope :from_client, lambda{|client_id| {:conditions=>["client_id = ?", client_id]}}

end
