defmodule CustomerPoints.CustomerPointBalances do
  @moduledoc """
  The CustomerPointBalances context.
  """

  import Ecto.Query, warn: false
  alias CustomerPoints.Repo

  alias CustomerPoints.CustomerPointBalances.CustomerPointBalance

  def get_customer_point_balance!(customer_id) do
    Repo.one!(
      from cpb in CustomerPointBalance,
        where: cpb.customer_id == ^customer_id,
        order_by: [desc: cpb.inserted_at],
        limit: 1
    )
  end

  def create_customer_point_balance(attrs \\ %{}, customer_id) do
    cpb =
      Repo.one!(
        from cpb in CustomerPointBalance,
          where: cpb.customer_id == ^customer_id,
          order_by: [desc: cpb.inserted_at],
          limit: 1
      )

    attrs = Map.put(attrs, :customer_id, customer_id)

    %CustomerPointBalance{
      prev_points: cpb.new_points
    }
    |> CustomerPointBalance.new_changeset(attrs)
    |> CustomerPointBalance.new_point_balance_modifications()
    |> Repo.insert()
  end
end
