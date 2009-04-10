require File.dirname(__FILE__) + '/../test_helper'

class PermissaosControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:permissaos)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_permissao
    assert_difference('Permissao.count') do
      post :create, :permissao => { }
    end

    assert_redirected_to permissao_path(assigns(:permissao))
  end

  def test_should_show_permissao
    get :show, :id => permissaos(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => permissaos(:one).id
    assert_response :success
  end

  def test_should_update_permissao
    put :update, :id => permissaos(:one).id, :permissao => { }
    assert_redirected_to permissao_path(assigns(:permissao))
  end

  def test_should_destroy_permissao
    assert_difference('Permissao.count', -1) do
      delete :destroy, :id => permissaos(:one).id
    end

    assert_redirected_to permissaos_path
  end
end
