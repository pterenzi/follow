require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def test_recent_comments
    task = tasks(:follow)
    user = task.requestor
    current_user = users(:marcio)
    comment = Comment.create(:task=>task, :user=>user, :description=>"Comment test")
    assert Comment.recent_comments(current_user.id).size==0
  end
end
