class Event < ActiveRecord::Base
  belongs_to :user
  
  def self.by_date(date,user_id)
    Event.all(:conditions=>["date = ? and user_id = ?",date,user_id])
  end
end
