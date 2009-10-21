require 'test_helper'

class PauseTest < ActiveSupport::TestCase
  
  def test_from_an_user_in_a_task
    pauses = Pause.from_an_user_in_a_task(5,1)
    assert pauses.size==2
  end
  
  def test_accepted
    assert Pause.accepted.size==2
  end
  
  def test_duration_in_minutes
    pause = pauses(:pattern2)
    assert pause.duration_in_minutes == 90
  end
  
end
