defmodule CustomerPoints.CustomersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CustomerPoints.Customers` context.
  """

  @doc """
  Generate a customer.
  """
  def customer_fixture(attrs \\ %{}) do
    {:ok, customer} =
      attrs
      |> Enum.into(%{
        email: "some email",
        phone_number: "some phone_number"
      })
      |> CustomerPoints.Customers.create_customer()

    customer
  end
end
