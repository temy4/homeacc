require 'test_helper'

class CategoriesGroupsControllerTest < ActionController::TestCase
  setup do
    @categories_group = categories_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categories_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create categories_group" do
    assert_difference('CategoriesGroup.count') do
      post :create, categories_group: { alias: @categories_group.alias, is_active: @categories_group.is_active, unit_category_id: @categories_group.unit_category_id }
    end

    assert_redirected_to categories_group_path(assigns(:categories_group))
  end

  test "should show categories_group" do
    get :show, id: @categories_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @categories_group
    assert_response :success
  end

  test "should update categories_group" do
    patch :update, id: @categories_group, categories_group: { alias: @categories_group.alias, is_active: @categories_group.is_active, unit_category_id: @categories_group.unit_category_id }
    assert_redirected_to categories_group_path(assigns(:categories_group))
  end

  test "should destroy categories_group" do
    assert_difference('CategoriesGroup.count', -1) do
      delete :destroy, id: @categories_group
    end

    assert_redirected_to categories_groups_path
  end
end
