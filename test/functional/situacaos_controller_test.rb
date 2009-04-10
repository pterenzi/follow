require File.dirname(__FILE__) + '/../test_helper'

class SituacaosControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:situacaos)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_situacao
    assert_difference('Situacao.count') do
      post :create, :situacao => { }
    end

    assert_redirected_to situacao_path(assigns(:situacao))
  end

  def test_should_show_situacao
    get :show, :id => situacaos(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => situacaos(:one).id
    assert_response :success
  end

  def test_should_update_situacao
    put :update, :id => situacaos(:one).id, :situacao => { }
    assert_redirected_to situacao_path(assigns(:situacao))
  end

  def test_should_destroy_situacao
    assert_difference('Situacao.count', -1) do
      delete :destroy, :id => situacaos(:one).id
    end

    assert_redirected_to situacaos_path
  end
end
