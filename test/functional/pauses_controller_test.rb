require 'test_helper'

class PausesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pauses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pause" do
    assert_difference('Pause.count') do
      post :create, :pause => { }
    end

    assert_redirected_to pause_path(assigns(:pause))
  end

  test "should show pause" do
    get :show, :id => pauses(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => pauses(:one).id
    assert_response :success
  end

  test "should update pause" do
    put :update, :id => pauses(:one).id, :pause => { }
    assert_redirected_to pause_path(assigns(:pause))
  end

  test "should destroy pause" do
    assert_difference('Pause.count', -1) do
      delete :destroy, :id => pauses(:one).id
    end

    assert_redirected_to pauses_path
  end
end
