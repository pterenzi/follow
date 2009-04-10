require File.dirname(__FILE__) + '/../test_helper'

class TarefasControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:tarefas)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_tarefa
    assert_difference('Tarefa.count') do
      post :create, :tarefa => { }
    end

    assert_redirected_to tarefa_path(assigns(:tarefa))
  end

  def test_should_show_tarefa
    get :show, :id => tarefas(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => tarefas(:one).id
    assert_response :success
  end

  def test_should_update_tarefa
    put :update, :id => tarefas(:one).id, :tarefa => { }
    assert_redirected_to tarefa_path(assigns(:tarefa))
  end

  def test_should_destroy_tarefa
    assert_difference('Tarefa.count', -1) do
      delete :destroy, :id => tarefas(:one).id
    end

    assert_redirected_to tarefas_path
  end
end
