require File.expand_path(File.dirname(__FILE__) + "/../test_helper")
class TaskTest < ActiveSupport::TestCase
  
  
  def test_user_da_task
    task = tasks(:follow)
    assert task.user.login=="marcio"
  end
  
   
end
