require File.dirname(__FILE__) + '/../test_helper'
class ProjectTest < ActiveSupport::TestCase
  # Substitua isto por seus testes
  def test_truth
    assert true
  end
  
  def test_follow_has_two_users
    project = projects(:follow)
    user = users(:marcio)
    assert project.users.include?(user)
  end
end
