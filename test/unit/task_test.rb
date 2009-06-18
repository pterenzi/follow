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
  
  def test_task_should_pausada
    task = tasks(:follow)
    assert task.pausada
  end
  
  def test_task_should_pausada_padrao
    task = tasks(:follow)
    assert task.pausada_padrao
  end
  
  def test_should_pausa_nao_aceita
    task = tasks(:didio)
    assert task.pausa_nao_aceita
    assert task.justificativa_recusa=='muito mal feito'
  end
  
  def test_verify_comments
    task = tasks(:follow)
    assert task.comentarios.size==1
    assert task.comentarios[0].descricao == "fazendo os testes"
  end
  
  def test_should_waiting_pause_acception
    task = tasks(:loja)
    assert task.pausada_esperando_aprovacao
  end
  
  

end
