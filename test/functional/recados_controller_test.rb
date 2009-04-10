require File.dirname(__FILE__) + '/../test_helper'

class RecadosControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:recados)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_recado
    assert_difference('Recado.count') do
      post :create, :recado => { }
    end

    assert_redirected_to recado_path(assigns(:recado))
  end

  def test_should_show_recado
    get :show, :id => recados(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => recados(:one).id
    assert_response :success
  end

  def test_should_update_recado
    put :update, :id => recados(:one).id, :recado => { }
    assert_redirected_to recado_path(assigns(:recado))
  end

  def test_should_destroy_recado
    assert_difference('Recado.count', -1) do
      delete :destroy, :id => recados(:one).id
    end

    assert_redirected_to recados_path
  end
end
