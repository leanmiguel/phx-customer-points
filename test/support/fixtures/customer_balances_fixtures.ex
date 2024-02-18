defmodule CustomerPoints.CustomerBalancesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CustomerPoints.CustomerBalances` context.
  """

  @doc """
  Generate a customer_balance.
  """
  def customer_balance_fixture(attrs \\ %{}) do
    {:ok, customer_balance} =
      attrs
      |> Enum.into(%{
        balance_change: 42,
        new_balance: 42,
        prev_balance: 42,
        type: "some type"
      })
      |> CustomerPoints.CustomerBalances.create_customer_balance()

    customer_balance
  end
end
