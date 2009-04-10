require File.dirname(__FILE__) + '/../test_helper'

class UsuariosHasProjetosControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:usuarios_has_projetos)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_usuarios_has_projeto
    assert_difference('UsuariosHasProjeto.count') do
      post :create, :usuarios_has_projeto => { }
    end

    assert_redirected_to usuarios_has_projeto_path(assigns(:usuarios_has_projeto))
  end

  def test_should_show_usuarios_has_projeto
    get :show, :id => usuarios_has_projetos(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => usuarios_has_projetos(:one).id
    assert_response :success
  end

  def test_should_update_usuarios_has_projeto
    put :update, :id => usuarios_has_projetos(:one).id, :usuarios_has_projeto => { }
    assert_redirected_to usuarios_has_projeto_path(assigns(:usuarios_has_projeto))
  end

  def test_should_destroy_usuarios_has_projeto
    assert_difference('UsuariosHasProjeto.count', -1) do
      delete :destroy, :id => usuarios_has_projetos(:one).id
    end

    assert_redirected_to usuarios_has_projetos_path
  end
end
