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
  
  def test_task_should_pauseda
    task = tasks(:follow)
    assert task.pauseda
  end
  
  def test_task_should_pauseda_pattern
    task = tasks(:follow)
    assert task.pauseda_pattern
  end
  
  def test_should_pause_nao_aceita
    task = tasks(:didio)
    assert task.pause_nao_aceita
    assert task.justification_recusa=='muito mal feito'
  end
  
  def test_verify_comments
    task = tasks(:follow)
    assert task.comments.size==1
    assert task.comments[0].description == "fazendo os testes"
  end
  
  def test_should_waiting_pause_acception
    task = tasks(:loja)
    assert task.pauseda_esperando_aprovacao
  end
  
  

end
