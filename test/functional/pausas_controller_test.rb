require 'test_helper'

class PausasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pausas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pausa" do
    assert_difference('Pausa.count') do
      post :create, :pausa => { }
    end

    assert_redirected_to pausa_path(assigns(:pausa))
  end

  test "should show pausa" do
    get :show, :id => pausas(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => pausas(:one).id
    assert_response :success
  end

  test "should update pausa" do
    put :update, :id => pausas(:one).id, :pausa => { }
    assert_redirected_to pausa_path(assigns(:pausa))
  end

  test "should destroy pausa" do
    assert_difference('Pausa.count', -1) do
      delete :destroy, :id => pausas(:one).id
    end

    assert_redirected_to pausas_path
  end
end
