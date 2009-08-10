require File.dirname(__FILE__) + '/../test_helper'
class MessageTest < ActiveSupport::TestCase

  def test_message
    message = messages(:one)
    paulo = users(:paulo)
    marcio = users(:marcio)
    debugger
    assert message.written_to == paulo
    assert message.written_by == marcio
  end
end
