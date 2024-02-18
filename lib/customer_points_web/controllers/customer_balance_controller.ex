defmodule CustomerPointsWeb.CustomerBalanceController do
  use CustomerPointsWeb, :controller

  alias CustomerPoints.CustomerBalances
  alias CustomerPoints.CustomerBalances.CustomerBalance

  action_fallback CustomerPointsWeb.FallbackController

  def index(conn, _params) do
    customer_balances = CustomerBalances.list_customer_balances()
    render(conn, :index, customer_balances: customer_balances)
  end

  def create(conn, %{"customer_balance" => customer_balance_params}) do
    with {:ok, %CustomerBalance{} = customer_balance} <- CustomerBalances.create_customer_balance(customer_balance_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/customer_balances/#{customer_balance}")
      |> render(:show, customer_balance: customer_balance)
    end
  end

  def show(conn, %{"id" => id}) do
    customer_balance = CustomerBalances.get_customer_balance!(id)
    render(conn, :show, customer_balance: customer_balance)
  end

  def update(conn, %{"id" => id, "customer_balance" => customer_balance_params}) do
    customer_balance = CustomerBalances.get_customer_balance!(id)

    with {:ok, %CustomerBalance{} = customer_balance} <- CustomerBalances.update_customer_balance(customer_balance, customer_balance_params) do
      render(conn, :show, customer_balance: customer_balance)
    end
  end

  def delete(conn, %{"id" => id}) do
    customer_balance = CustomerBalances.get_customer_balance!(id)

    with {:ok, %CustomerBalance{}} <- CustomerBalances.delete_customer_balance(customer_balance) do
      send_resp(conn, :no_content, "")
    end
  end
end
