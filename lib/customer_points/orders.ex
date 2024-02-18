defmodule CustomerPoints.Orders do
  @moduledoc """
  The Orders context.
  """

  import Ecto.Query, warn: false
  alias CustomerPoints.Repo

  alias CustomerPoints.Orders.Order
  alias CustomerPoints.CustomerBalances
  alias CustomerPoints.CustomerPointBalances

  # TODO: can move to db
  @point_rate 0.01

  def create_order(attrs \\ %{}, customer) do
    attrs = Map.put(attrs, :customer_id, customer.id)

    multi =
      Ecto.Multi.new()
      |> Ecto.Multi.insert(:order, Order.changeset(%Order{}, attrs))
      |> Ecto.Multi.run(:customer_balance, fn _repo, _multi ->
        CustomerBalances.create_customer_balance(
          %{
            balance_change: -attrs[:paid]
          },
          customer.id
        )
      end)
      |> Ecto.Multi.run(:customer_point_balance, fn _repo, _multi ->
        CustomerPointBalances.create_customer_point_balance(
          %{
            points_change: attrs[:paid] * @point_rate
          },
          customer.id
        )
      end)

    case Repo.transaction(multi) do
      {:ok, %{order: order}} ->
        {:ok, order}

      {:error, _, reason, _changes} ->
        {:error, reason}
    end
  end
end
