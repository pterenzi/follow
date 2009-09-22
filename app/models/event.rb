class Event < ActiveRecord::Base
  belongs_to :user
  
  def self.by_date(date,user_id)
    debugger
    Event.all(:conditions=>["start_at >= ? and start_at <= ? and user_id = ?",date.to_s + " 00:00",date.to_s + " 23:59", user_id])
  end
end
