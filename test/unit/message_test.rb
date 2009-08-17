require File.dirname(__FILE__) + '/../test_helper'
class MessageTest < ActiveSupport::TestCase

  def test_message
    message = messages(:one)
    paulo = users(:paulo)
    marcio = users(:marcio)
    assert message.user_id == paulo
    assert message.written_by == marcio
  end
  
  def test_my_messages
  	messages = Message.my_messages(391950614)
  	assert messages.size==1
  	first = messages[0]
  	marcio = users(:marcio)
  	assert first.user_id == marcio
  end
  
end
