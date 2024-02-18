defmodule CustomerPoints.CustomerPointBalancesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CustomerPoints.CustomerPointBalances` context.
  """

  @doc """
  Generate a customer_point_balance.
  """
  def customer_point_balance_fixture(attrs \\ %{}) do
    {:ok, customer_point_balance} =
      attrs
      |> Enum.into(%{
        new_points: 42,
        points_change: 42,
        prev_points: 42,
        type: "some type"
      })
      |> CustomerPoints.CustomerPointBalances.create_customer_point_balance()

    customer_point_balance
  end
end
