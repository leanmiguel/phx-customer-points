defmodule CustomerPoints.CustomerPointBalancesTest do
  use CustomerPoints.DataCase

  alias CustomerPoints.CustomerPointBalances

  describe "customer_point_balances" do
    alias CustomerPoints.CustomerPointBalances.CustomerPointBalance

    import CustomerPoints.CustomerPointBalancesFixtures

    @invalid_attrs %{new_points: nil, points_change: nil, prev_points: nil, type: nil}

    test "list_customer_point_balances/0 returns all customer_point_balances" do
      customer_point_balance = customer_point_balance_fixture()
      assert CustomerPointBalances.list_customer_point_balances() == [customer_point_balance]
    end

    test "get_customer_point_balance!/1 returns the customer_point_balance with given id" do
      customer_point_balance = customer_point_balance_fixture()
      assert CustomerPointBalances.get_customer_point_balance!(customer_point_balance.id) == customer_point_balance
    end

    test "create_customer_point_balance/1 with valid data creates a customer_point_balance" do
      valid_attrs = %{new_points: 42, points_change: 42, prev_points: 42, type: "some type"}

      assert {:ok, %CustomerPointBalance{} = customer_point_balance} = CustomerPointBalances.create_customer_point_balance(valid_attrs)
      assert customer_point_balance.new_points == 42
      assert customer_point_balance.points_change == 42
      assert customer_point_balance.prev_points == 42
      assert customer_point_balance.type == "some type"
    end

    test "create_customer_point_balance/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CustomerPointBalances.create_customer_point_balance(@invalid_attrs)
    end

    test "update_customer_point_balance/2 with valid data updates the customer_point_balance" do
      customer_point_balance = customer_point_balance_fixture()
      update_attrs = %{new_points: 43, points_change: 43, prev_points: 43, type: "some updated type"}

      assert {:ok, %CustomerPointBalance{} = customer_point_balance} = CustomerPointBalances.update_customer_point_balance(customer_point_balance, update_attrs)
      assert customer_point_balance.new_points == 43
      assert customer_point_balance.points_change == 43
      assert customer_point_balance.prev_points == 43
      assert customer_point_balance.type == "some updated type"
    end

    test "update_customer_point_balance/2 with invalid data returns error changeset" do
      customer_point_balance = customer_point_balance_fixture()
      assert {:error, %Ecto.Changeset{}} = CustomerPointBalances.update_customer_point_balance(customer_point_balance, @invalid_attrs)
      assert customer_point_balance == CustomerPointBalances.get_customer_point_balance!(customer_point_balance.id)
    end

    test "delete_customer_point_balance/1 deletes the customer_point_balance" do
      customer_point_balance = customer_point_balance_fixture()
      assert {:ok, %CustomerPointBalance{}} = CustomerPointBalances.delete_customer_point_balance(customer_point_balance)
      assert_raise Ecto.NoResultsError, fn -> CustomerPointBalances.get_customer_point_balance!(customer_point_balance.id) end
    end

    test "change_customer_point_balance/1 returns a customer_point_balance changeset" do
      customer_point_balance = customer_point_balance_fixture()
      assert %Ecto.Changeset{} = CustomerPointBalances.change_customer_point_balance(customer_point_balance)
    end
  end
end
