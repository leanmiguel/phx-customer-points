defmodule CustomerPoints.OrdersTest do
  use CustomerPoints.DataCase

  alias CustomerPoints.Orders

  describe "orders" do
    alias CustomerPoints.Orders.Order

    import CustomerPoints.OrdersFixtures

    @invalid_attrs %{currency: nil, order_id: nil, paid: nil}

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Orders.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Orders.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      valid_attrs = %{currency: "some currency", order_id: "7488a646-e31f-11e4-aace-600308960662", paid: 42}

      assert {:ok, %Order{} = order} = Orders.create_order(valid_attrs)
      assert order.currency == "some currency"
      assert order.order_id == "7488a646-e31f-11e4-aace-600308960662"
      assert order.paid == 42
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      update_attrs = %{currency: "some updated currency", order_id: "7488a646-e31f-11e4-aace-600308960668", paid: 43}

      assert {:ok, %Order{} = order} = Orders.update_order(order, update_attrs)
      assert order.currency == "some updated currency"
      assert order.order_id == "7488a646-e31f-11e4-aace-600308960668"
      assert order.paid == 43
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_order(order, @invalid_attrs)
      assert order == Orders.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Orders.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Orders.change_order(order)
    end
  end
end
