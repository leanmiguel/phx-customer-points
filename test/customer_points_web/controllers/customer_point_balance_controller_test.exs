defmodule CustomerPointsWeb.CustomerPointBalanceControllerTest do
  use CustomerPointsWeb.ConnCase

  import CustomerPoints.CustomerPointBalancesFixtures

  alias CustomerPoints.CustomerPointBalances.CustomerPointBalance

  @create_attrs %{
    new_points: 42,
    points_change: 42,
    prev_points: 42,
    type: "some type"
  }
  @update_attrs %{
    new_points: 43,
    points_change: 43,
    prev_points: 43,
    type: "some updated type"
  }
  @invalid_attrs %{new_points: nil, points_change: nil, prev_points: nil, type: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all customer_point_balances", %{conn: conn} do
      conn = get(conn, ~p"/api/customer_point_balances")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create customer_point_balance" do
    test "renders customer_point_balance when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/customer_point_balances", customer_point_balance: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/customer_point_balances/#{id}")

      assert %{
               "id" => ^id,
               "new_points" => 42,
               "points_change" => 42,
               "prev_points" => 42,
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/customer_point_balances", customer_point_balance: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update customer_point_balance" do
    setup [:create_customer_point_balance]

    test "renders customer_point_balance when data is valid", %{conn: conn, customer_point_balance: %CustomerPointBalance{id: id} = customer_point_balance} do
      conn = put(conn, ~p"/api/customer_point_balances/#{customer_point_balance}", customer_point_balance: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/customer_point_balances/#{id}")

      assert %{
               "id" => ^id,
               "new_points" => 43,
               "points_change" => 43,
               "prev_points" => 43,
               "type" => "some updated type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, customer_point_balance: customer_point_balance} do
      conn = put(conn, ~p"/api/customer_point_balances/#{customer_point_balance}", customer_point_balance: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete customer_point_balance" do
    setup [:create_customer_point_balance]

    test "deletes chosen customer_point_balance", %{conn: conn, customer_point_balance: customer_point_balance} do
      conn = delete(conn, ~p"/api/customer_point_balances/#{customer_point_balance}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/customer_point_balances/#{customer_point_balance}")
      end
    end
  end

  defp create_customer_point_balance(_) do
    customer_point_balance = customer_point_balance_fixture()
    %{customer_point_balance: customer_point_balance}
  end
end
