require 'test_helper'

class PatternPausesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pattern_pauses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pattern_pause" do
    assert_difference('PatternPause.count') do
      post :create, :pattern_pause => { }
    end

    assert_redirected_to pattern_pause_path(assigns(:pattern_pause))
  end

  test "should show pattern_pause" do
    get :show, :id => pattern_pauses(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => pattern_pauses(:one).id
    assert_response :success
  end

  test "should update pattern_pause" do
    put :update, :id => pattern_pauses(:one).id, :pattern_pause => { }
    assert_redirected_to pattern_pause_path(assigns(:pattern_pause))
  end

  test "should destroy pattern_pause" do
    assert_difference('PatternPause.count', -1) do
      delete :destroy, :id => pattern_pauses(:one).id
    end

    assert_redirected_to pattern_pauses_path
  end
end
