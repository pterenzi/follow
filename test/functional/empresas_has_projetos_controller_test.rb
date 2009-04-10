require File.dirname(__FILE__) + '/../test_helper'

class EmpresasHasProjetosControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:empresas_has_projetos)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_empresas_has_projeto
    assert_difference('EmpresasHasProjeto.count') do
      post :create, :empresas_has_projeto => { }
    end

    assert_redirected_to empresas_has_projeto_path(assigns(:empresas_has_projeto))
  end

  def test_should_show_empresas_has_projeto
    get :show, :id => empresas_has_projetos(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => empresas_has_projetos(:one).id
    assert_response :success
  end

  def test_should_update_empresas_has_projeto
    put :update, :id => empresas_has_projetos(:one).id, :empresas_has_projeto => { }
    assert_redirected_to empresas_has_projeto_path(assigns(:empresas_has_projeto))
  end

  def test_should_destroy_empresas_has_projeto
    assert_difference('EmpresasHasProjeto.count', -1) do
      delete :destroy, :id => empresas_has_projetos(:one).id
    end

    assert_redirected_to empresas_has_projetos_path
  end
end
