require File.dirname(__FILE__) + '/../test_helper'
class SituacaoTest < ActiveSupport::TestCase
  # Substitua isto por seus testes
  def test_truth
    assert true
  end
  
  def test_should_not_save_without_descricao
    situacao = Situacao.new
    assert !situacao.save, "Salvou situação sem descricao."
  end
end
