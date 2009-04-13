require File.dirname(__FILE__) + '/../test_helper'
class TarefaTest < ActiveSupport::TestCase
  def test_should_not_save_without_descricao
     tarefa = Tarefa.new
     tarefa.usuario_id=1
     tarefa.projeto_id=1
     tarefa.situacao_id=1
     assert !tarefa.save, "Salvou tarefa sem descricao."
  end
  
  def test_should_not_save_without_projeto
    tarefa = Tarefa.new
    tarefa.usuario_id=1
    tarefa.descricao='d'
    tarefa.situacao_id=1
    tarefa.usuario_executor_id=2
    assert !tarefa.save,"Salvou a tarefa sem projeto"
  end
  
  def test_should_not_save_without_usuario
    tarefa = Tarefa.new
    tarefa.descricao='d'
    tarefa.projeto_id=1
    tarefa.situacao_id=1
    tarefa.usuario_executor_id=2
    assert !tarefa.save,"Salvou a terafa sem usuario"
  end

  def test_should_not_save_without_situacao
    tarefa = Tarefa.new
    tarefa.usuario_id=1
    tarefa.usuario_executor_id=2
    tarefa.projeto_id=1
    tarefa.descricao='d'
    
    assert !tarefa.save,"Salvou a terafa sem situacao"
  end
   
end
