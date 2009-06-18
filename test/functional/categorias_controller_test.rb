require File.dirname(__FILE__) + '/../test_helper'

class CategoriesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_categories
    assert_difference('Categories.count') do
      post :create, :categories => { }
    end

    assert_redirected_to categories_path(assigns(:categories))
  end

  def test_should_show_categories
    get :show, :id => categories(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => categories(:one).id
    assert_response :success
  end

  def test_should_update_categories
    put :update, :id => categories(:one).id, :categories => { }
    assert_redirected_to categories_path(assigns(:categories))
  end

  def test_should_destroy_categories
    assert_difference('Categories.count', -1) do
      delete :destroy, :id => categories(:one).id
    end

    assert_redirected_to categories_path
  end
end
