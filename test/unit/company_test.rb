require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  def test_users
    way = companies(:way)
    assert way.users[0].login=="admin"
    ana = companies(:ana)
    assert ana.users[0].login=="marcio"
  end
  
end
