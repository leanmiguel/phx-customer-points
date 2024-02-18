defmodule CustomerPointsWeb.OrderController do
  use CustomerPointsWeb, :controller

  alias CustomerPoints.Orders
  alias CustomerPoints.Orders.Order

  action_fallback CustomerPointsWeb.FallbackController

  def create(conn, %{"order" => order_params}) do
    with {:ok, %Order{} = order} <- Orders.create_order(order_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/orders/#{order}")
      |> render(:show, order: order)
    end
  end
end
