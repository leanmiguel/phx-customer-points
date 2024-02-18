defmodule CustomerPoints.CustomerBalances do
  @moduledoc """
  The CustomerBalances context.
  """

  import Ecto.Query, warn: false
  alias CustomerPoints.Repo

  alias CustomerPoints.CustomerBalances.CustomerBalance

  def get_customer_balance!(customer_id) do
    Repo.one!(
      from cb in CustomerBalance,
        where: cb.customer_id == ^customer_id,
        order_by: [desc: cb.inserted_at],
        limit: 1
    )
  end

  def create_customer_balance(attrs \\ %{}, customer_id) do
    b =
      Repo.one!(
        from cb in CustomerBalance,
          where: cb.customer_id == ^customer_id,
          order_by: [desc: cb.inserted_at],
          limit: 1
      )

    %CustomerBalance{
      customer_id: b.customer_id,
      prev_balance: b.new_balance
    }
    |> CustomerBalance.new_balance_changeset(attrs)
    |> CustomerBalance.new_balance_modifications()
    |> Repo.insert()
  end
end
