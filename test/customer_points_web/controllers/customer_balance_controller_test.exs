defmodule CustomerPointsWeb.CustomerBalanceControllerTest do
  use CustomerPointsWeb.ConnCase

  import CustomerPoints.CustomerBalancesFixtures

  alias CustomerPoints.CustomerBalances.CustomerBalance

  @create_attrs %{
    balance_change: 42,
    new_balance: 42,
    prev_balance: 42,
    type: "some type"
  }
  @update_attrs %{
    balance_change: 43,
    new_balance: 43,
    prev_balance: 43,
    type: "some updated type"
  }
  @invalid_attrs %{balance_change: nil, new_balance: nil, prev_balance: nil, type: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all customer_balances", %{conn: conn} do
      conn = get(conn, ~p"/api/customer_balances")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create customer_balance" do
    test "renders customer_balance when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/customer_balances", customer_balance: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/customer_balances/#{id}")

      assert %{
               "id" => ^id,
               "balance_change" => 42,
               "new_balance" => 42,
               "prev_balance" => 42,
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/customer_balances", customer_balance: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update customer_balance" do
    setup [:create_customer_balance]

    test "renders customer_balance when data is valid", %{conn: conn, customer_balance: %CustomerBalance{id: id} = customer_balance} do
      conn = put(conn, ~p"/api/customer_balances/#{customer_balance}", customer_balance: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/customer_balances/#{id}")

      assert %{
               "id" => ^id,
               "balance_change" => 43,
               "new_balance" => 43,
               "prev_balance" => 43,
               "type" => "some updated type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, customer_balance: customer_balance} do
      conn = put(conn, ~p"/api/customer_balances/#{customer_balance}", customer_balance: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete customer_balance" do
    setup [:create_customer_balance]

    test "deletes chosen customer_balance", %{conn: conn, customer_balance: customer_balance} do
      conn = delete(conn, ~p"/api/customer_balances/#{customer_balance}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/customer_balances/#{customer_balance}")
      end
    end
  end

  defp create_customer_balance(_) do
    customer_balance = customer_balance_fixture()
    %{customer_balance: customer_balance}
  end
end
