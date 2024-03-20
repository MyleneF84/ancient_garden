require "test_helper"

class Admins::OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admins_order = admins_orders(:one)
  end

  test "should get index" do
    get admins_orders_url
    assert_response :success
  end

  test "should get new" do
    get new_admins_order_url
    assert_response :success
  end

  test "should create admins_order" do
    assert_difference("Admins::Order.count") do
      post admins_orders_url, params: { admins_order: { address: @admins_order.address, customer_email: @admins_order.customer_email, fulfilled: @admins_order.fulfilled, total: @admins_order.total } }
    end

    assert_redirected_to admins_order_url(Admins::Order.last)
  end

  test "should show admins_order" do
    get admins_order_url(@admins_order)
    assert_response :success
  end

  test "should get edit" do
    get edit_admins_order_url(@admins_order)
    assert_response :success
  end

  test "should update admins_order" do
    patch admins_order_url(@admins_order), params: { admins_order: { address: @admins_order.address, customer_email: @admins_order.customer_email, fulfilled: @admins_order.fulfilled, total: @admins_order.total } }
    assert_redirected_to admins_order_url(@admins_order)
  end

  test "should destroy admins_order" do
    assert_difference("Admins::Order.count", -1) do
      delete admins_order_url(@admins_order)
    end

    assert_redirected_to admins_orders_url
  end
end
