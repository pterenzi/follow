require 'test_helper'

class PausaPadraosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pausa_padraos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pausa_padrao" do
    assert_difference('PausaPadrao.count') do
      post :create, :pausa_padrao => { }
    end

    assert_redirected_to pausa_padrao_path(assigns(:pausa_padrao))
  end

  test "should show pausa_padrao" do
    get :show, :id => pausa_padraos(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => pausa_padraos(:one).id
    assert_response :success
  end

  test "should update pausa_padrao" do
    put :update, :id => pausa_padraos(:one).id, :pausa_padrao => { }
    assert_redirected_to pausa_padrao_path(assigns(:pausa_padrao))
  end

  test "should destroy pausa_padrao" do
    assert_difference('PausaPadrao.count', -1) do
      delete :destroy, :id => pausa_padraos(:one).id
    end

    assert_redirected_to pausa_padraos_path
  end
end
