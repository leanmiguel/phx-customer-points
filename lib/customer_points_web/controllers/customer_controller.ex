defmodule CustomerPointsWeb.CustomerController do
  use CustomerPointsWeb, :controller

  alias CustomerPoints.Customers
  alias CustomerPoints.Customers.Customer

  action_fallback CustomerPointsWeb.FallbackController

  def create(conn, %{"customer" => customer_params}) do
    with {:ok, %Customer{} = customer} <- Customers.create_customer(customer_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/customers/#{customer}")
      |> render(:show, customer: customer)
    end
  end
end
