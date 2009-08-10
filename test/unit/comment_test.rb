require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  def test_recent_comments
    task = tasks(:follow)
    user = task.requestor
    current_user = users(:marcio)
    comment = Comment.create(:task=>task, :user=>user, :description=>"Comment test")
    debugger
    assert Comment.recent_comments(current_user.id).size==0
  end
end
