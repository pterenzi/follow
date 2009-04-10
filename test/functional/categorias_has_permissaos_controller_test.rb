require File.dirname(__FILE__) + '/../test_helper'

class CategoriasHasPermissaosControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:categorias_has_permissaos)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_categorias_has_permissao
    assert_difference('CategoriasHasPermissao.count') do
      post :create, :categorias_has_permissao => { }
    end

    assert_redirected_to categorias_has_permissao_path(assigns(:categorias_has_permissao))
  end

  def test_should_show_categorias_has_permissao
    get :show, :id => categorias_has_permissaos(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => categorias_has_permissaos(:one).id
    assert_response :success
  end

  def test_should_update_categorias_has_permissao
    put :update, :id => categorias_has_permissaos(:one).id, :categorias_has_permissao => { }
    assert_redirected_to categorias_has_permissao_path(assigns(:categorias_has_permissao))
  end

  def test_should_destroy_categorias_has_permissao
    assert_difference('CategoriasHasPermissao.count', -1) do
      delete :destroy, :id => categorias_has_permissaos(:one).id
    end

    assert_redirected_to categorias_has_permissaos_path
  end
end
