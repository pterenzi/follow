require File.expand_path(File.dirname(__FILE__) + "/../test_helper")
class TaskTest < ActiveSupport::TestCase
  
  
  def test_user_da_task
    task = tasks(:follow)
    assert task.user.login=="marcio"
  end
  
  def test_sem_usuario
    task = tasks(:encerrada)
    assert  task.user.nil?
  end
  
  def test_task_should_paused
    task = tasks(:follow)
    assert task.paused
  end
  
  def test_task_should_paused_pattern
    task = tasks(:follow)
    assert task.paused_pattern
  end
  
  def test_should_pause_nao_aceita
    task = tasks(:didio)
    #TODO teste com erro
#    assert task.pause_nao_aceita
  end
  
  def test_verify_comments
    task = tasks(:follow)
    assert task.comments.size==1
    assert task.comments[0].description == "fazendo os testes"
  end
  
  def test_should_waiting_pause_acception
    task = tasks(:loja)
    assert task.paused_esperando_aprovacao
  end
  
  def test_usuario_que_criou
    task = tasks(:loja)
    marcio = users(:marcio)
    assert task.usuario_que_criou(marcio.id) 
  end

  def test_for_user
    tasks =  
    debugger
    assert Task.for_user(1).size==2
    assert Task.for_user(2).size==1
    assert Task.for_user(5).size==0
  end
end
