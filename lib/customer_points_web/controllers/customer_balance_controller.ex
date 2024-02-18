defmodule CustomerPointsWeb.CustomerBalanceController do
  use CustomerPointsWeb, :controller

  alias CustomerPoints.CustomerBalances
  alias CustomerPoints.CustomerBalances.CustomerBalance

  action_fallback CustomerPointsWeb.FallbackController

  def create(conn, %{"customer_balance" => customer_balance_params, "customer_id" => customer_id}) do
    with {:ok, %CustomerBalance{} = customer_balance} <-
           CustomerBalances.create_manual_customer_balance(customer_balance_params, customer_id) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/customer_balances/#{customer_balance}")
      |> render(:show, customer_balance: customer_balance)
    end
  end

  def show(conn, %{"customer_id" => customer_id}) do
    customer_balance = CustomerBalances.get_customer_balance!(customer_id)
    render(conn, :show_customer_balance, customer_balance: customer_balance)
  end
end
