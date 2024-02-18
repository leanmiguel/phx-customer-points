defmodule CustomerPoints.OrdersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CustomerPoints.Orders` context.
  """

  @doc """
  Generate a order.
  """
  def order_fixture(attrs \\ %{}) do
    {:ok, order} =
      attrs
      |> Enum.into(%{
        currency: "some currency",
        order_id: "7488a646-e31f-11e4-aace-600308960662",
        paid: 42
      })
      |> CustomerPoints.Orders.create_order()

    order
  end
end
