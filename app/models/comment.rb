class Comment < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
#  validates_presence_of :usuario_id
  validates_presence_of :description
  
  
  def self.recent_comments(current_user)
    recent_comments = Comment.all(:order=>"created_at Desc", :limit=>20)
    tasks_comments = Array.new
    for comment in recent_comments
      if (comment.created_at > Time.now - 1.minute ) && (comment.task.user_id == current_user.id)
        if !tasks_comments.include?(comment.task.id)
          tasks_comments << comment.task
        end
      end  
    end
    tasks_comments 
  end
  
  def self.create_comment_for_test
    Comment.create(:user_id=>2,:description=>"teste comentário",:task_id=>34)
  end
end
