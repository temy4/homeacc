require 'test_helper'

class MoneyUnitsControllerTest < ActionController::TestCase
  setup do
    @money_unit = money_units(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:money_units)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create money_unit" do
    assert_difference('MoneyUnit.count') do
      post :create, money_unit: { counterparty_id: @money_unit.counterparty_id, currency_id: @money_unit.currency_id, current_period: @money_unit.current_period, current_period_price: @money_unit.current_period_price, is_active: @money_unit.is_active, name: @money_unit.name, next_period: @money_unit.next_period, next_period_price: @money_unit.next_period_price, period: @money_unit.period, tax_id: @money_unit.tax_id, type: @money_unit.type }
    end

    assert_redirected_to money_unit_path(assigns(:money_unit))
  end

  test "should show money_unit" do
    get :show, id: @money_unit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @money_unit
    assert_response :success
  end

  test "should update money_unit" do
    patch :update, id: @money_unit, money_unit: { counterparty_id: @money_unit.counterparty_id, currency_id: @money_unit.currency_id, current_period: @money_unit.current_period, current_period_price: @money_unit.current_period_price, is_active: @money_unit.is_active, name: @money_unit.name, next_period: @money_unit.next_period, next_period_price: @money_unit.next_period_price, period: @money_unit.period, tax_id: @money_unit.tax_id, type: @money_unit.type }
    assert_redirected_to money_unit_path(assigns(:money_unit))
  end

  test "should destroy money_unit" do
    assert_difference('MoneyUnit.count', -1) do
      delete :destroy, id: @money_unit
    end

    assert_redirected_to money_units_path
  end
end
