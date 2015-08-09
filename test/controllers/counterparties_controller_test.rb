require 'test_helper'

class CounterpartiesControllerTest < ActionController::TestCase
  setup do
    @counterparty = counterparties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:counterparties)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create counterparty" do
    assert_difference('Counterparty.count') do
      post :create, counterparty: { counterparty_name: @counterparty.counterparty_name }
    end

    assert_redirected_to counterparty_path(assigns(:counterparty))
  end

  test "should show counterparty" do
    get :show, id: @counterparty
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @counterparty
    assert_response :success
  end

  test "should update counterparty" do
    patch :update, id: @counterparty, counterparty: { counterparty_name: @counterparty.counterparty_name }
    assert_redirected_to counterparty_path(assigns(:counterparty))
  end

  test "should destroy counterparty" do
    assert_difference('Counterparty.count', -1) do
      delete :destroy, id: @counterparty
    end

    assert_redirected_to counterparties_path
  end
end
