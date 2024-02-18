defmodule CustomerPoints.CustomerBalancesTest do
  use CustomerPoints.DataCase

  alias CustomerPoints.CustomerBalances

  describe "customer_balances" do
    alias CustomerPoints.CustomerBalances.CustomerBalance

    import CustomerPoints.CustomerBalancesFixtures

    @invalid_attrs %{balance_change: nil, new_balance: nil, prev_balance: nil, type: nil}

    test "list_customer_balances/0 returns all customer_balances" do
      customer_balance = customer_balance_fixture()
      assert CustomerBalances.list_customer_balances() == [customer_balance]
    end

    test "get_customer_balance!/1 returns the customer_balance with given id" do
      customer_balance = customer_balance_fixture()
      assert CustomerBalances.get_customer_balance!(customer_balance.id) == customer_balance
    end

    test "create_customer_balance/1 with valid data creates a customer_balance" do
      valid_attrs = %{balance_change: 42, new_balance: 42, prev_balance: 42, type: "some type"}

      assert {:ok, %CustomerBalance{} = customer_balance} = CustomerBalances.create_customer_balance(valid_attrs)
      assert customer_balance.balance_change == 42
      assert customer_balance.new_balance == 42
      assert customer_balance.prev_balance == 42
      assert customer_balance.type == "some type"
    end

    test "create_customer_balance/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CustomerBalances.create_customer_balance(@invalid_attrs)
    end

    test "update_customer_balance/2 with valid data updates the customer_balance" do
      customer_balance = customer_balance_fixture()
      update_attrs = %{balance_change: 43, new_balance: 43, prev_balance: 43, type: "some updated type"}

      assert {:ok, %CustomerBalance{} = customer_balance} = CustomerBalances.update_customer_balance(customer_balance, update_attrs)
      assert customer_balance.balance_change == 43
      assert customer_balance.new_balance == 43
      assert customer_balance.prev_balance == 43
      assert customer_balance.type == "some updated type"
    end

    test "update_customer_balance/2 with invalid data returns error changeset" do
      customer_balance = customer_balance_fixture()
      assert {:error, %Ecto.Changeset{}} = CustomerBalances.update_customer_balance(customer_balance, @invalid_attrs)
      assert customer_balance == CustomerBalances.get_customer_balance!(customer_balance.id)
    end

    test "delete_customer_balance/1 deletes the customer_balance" do
      customer_balance = customer_balance_fixture()
      assert {:ok, %CustomerBalance{}} = CustomerBalances.delete_customer_balance(customer_balance)
      assert_raise Ecto.NoResultsError, fn -> CustomerBalances.get_customer_balance!(customer_balance.id) end
    end

    test "change_customer_balance/1 returns a customer_balance changeset" do
      customer_balance = customer_balance_fixture()
      assert %Ecto.Changeset{} = CustomerBalances.change_customer_balance(customer_balance)
    end
  end
end
