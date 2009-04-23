require 'test_helper'

class AndamentosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:andamentos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create andamento" do
    assert_difference('Andamento.count') do
      post :create, :andamento => { }
    end

    assert_redirected_to andamento_path(assigns(:andamento))
  end

  test "should show andamento" do
    get :show, :id => andamentos(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => andamentos(:one).id
    assert_response :success
  end

  test "should update andamento" do
    put :update, :id => andamentos(:one).id, :andamento => { }
    assert_redirected_to andamento_path(assigns(:andamento))
  end

  test "should destroy andamento" do
    assert_difference('Andamento.count', -1) do
      delete :destroy, :id => andamentos(:one).id
    end

    assert_redirected_to andamentos_path
  end
end
