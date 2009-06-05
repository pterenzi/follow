require File.expand_path(File.dirname(__FILE__) + "/../test_helper")
class TarefaTest < ActiveSupport::TestCase
  
  
  def test_user_da_tarefa
    tarefa = tarefas(:follow)
    assert tarefa.user.login=="marcio"
  end
  
   
end
