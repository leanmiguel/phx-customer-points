defmodule CustomerPointsWeb.CustomerPointBalanceController do
  use CustomerPointsWeb, :controller

  alias CustomerPoints.CustomerPointBalances
  alias CustomerPoints.CustomerPointBalances.CustomerPointBalance

  action_fallback CustomerPointsWeb.FallbackController

  def index(conn, _params) do
    customer_point_balances = CustomerPointBalances.list_customer_point_balances()
    render(conn, :index, customer_point_balances: customer_point_balances)
  end

  def create(conn, %{"customer_point_balance" => customer_point_balance_params}) do
    with {:ok, %CustomerPointBalance{} = customer_point_balance} <- CustomerPointBalances.create_customer_point_balance(customer_point_balance_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/customer_point_balances/#{customer_point_balance}")
      |> render(:show, customer_point_balance: customer_point_balance)
    end
  end

  def show(conn, %{"id" => id}) do
    customer_point_balance = CustomerPointBalances.get_customer_point_balance!(id)
    render(conn, :show, customer_point_balance: customer_point_balance)
  end

  def update(conn, %{"id" => id, "customer_point_balance" => customer_point_balance_params}) do
    customer_point_balance = CustomerPointBalances.get_customer_point_balance!(id)

    with {:ok, %CustomerPointBalance{} = customer_point_balance} <- CustomerPointBalances.update_customer_point_balance(customer_point_balance, customer_point_balance_params) do
      render(conn, :show, customer_point_balance: customer_point_balance)
    end
  end

  def delete(conn, %{"id" => id}) do
    customer_point_balance = CustomerPointBalances.get_customer_point_balance!(id)

    with {:ok, %CustomerPointBalance{}} <- CustomerPointBalances.delete_customer_point_balance(customer_point_balance) do
      send_resp(conn, :no_content, "")
    end
  end
end
