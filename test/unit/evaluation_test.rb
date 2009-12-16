require 'test_helper'

class EvaluationTest < ActiveSupport::TestCase
   def test_from_user
     task = tasks(:didio)
     user = users(:paulo)
     evaluation = evaluations(:didio)
     assert evaluation.comment=="muito mal feito"
     from_user = Evaluation.from_user(task.id,user.id).first
     assert from_user.grade==3
   end
end
