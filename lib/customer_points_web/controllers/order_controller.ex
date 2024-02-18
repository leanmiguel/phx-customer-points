defmodule CustomerPointsWeb.OrderController do
  use CustomerPointsWeb, :controller

  alias CustomerPoints.Orders
  alias CustomerPoints.Orders.Order
  alias CustomerPoints.Customers

  action_fallback CustomerPointsWeb.FallbackController

  def create(conn, %{"order" => order_params, "customer" => customer_params}) do
    customer =
      Customers.get_customer_by_email_or_number(
        customer_params["email"],
        customer_params["phone_number"]
      )

    with {:ok, %Order{} = order} <- Orders.create_order(order_params, customer) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/orders/#{order}")
      |> render(:show, order: order)
    end
  end
end
