require File.dirname(__FILE__) + '/../test_helper'

class ProjectsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:projetos)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_projeto
    assert_difference('Project.count') do
      post :create, :project => { }
    end

    assert_redirected_to projeto_path(assigns(:project))
  end

  def test_should_show_projeto
    get :show, :id => projetos(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => projetos(:one).id
    assert_response :success
  end

  def test_should_update_projeto
    put :update, :id => projetos(:one).id, :projeto => { }
    assert_redirected_to projeto_path(assigns(:projeto))
  end

  def test_should_destroy_projeto
    assert_difference('Project.count', -1) do
      delete :destroy, :id => projetos(:one).id
    end

    assert_redirected_to projetos_path
  end
end
