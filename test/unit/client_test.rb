require 'test_helper'

class ClientTest < ActiveSupport::TestCase

  def test_license_full
     client = clients(:ford)
     assert client.license_full==false
  end
  
  def test_available_license
    client = clients(:ford)
    assert client.available_license == 3
  end

end
