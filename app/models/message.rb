class Message < ActiveRecord::Base
#Relacionamentos

validates_presence_of :user_id, :on => :create, :message => "can't be blank"
validates_presence_of :content, :on => :create, :message => "can't be blank"

belongs_to :written_by, :class_name => "User", :foreign_key => "written_by"
belongs_to :user

named_scope :order_by_created_at, :order=>:created_at
named_scope :my_messages, lambda{ |id| {:conditions=>["user_id = ?", id]} }
named_scope :not_readed, lambda{ |id| {:conditions=>["user_id = ? and readed IS NULL", id], 
  :order => "created_at DESC",
  :include => [:written_by]} }

def self.recent_messages(current_user)
  messages = Message.all(:order=>"created_at desc", :conditions=>["user_id=? and readed IS NULL", current_user], :limit=>10)
  result = Array.new
  for message in messages
    if message.created_at > Time.current - 1.minute
      result << message
      puts message.content
    end
  end
  return result
end

end
