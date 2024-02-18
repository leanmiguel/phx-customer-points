defmodule CustomerPoints.CustomerPointBalances do
  @moduledoc """
  The CustomerPointBalances context.
  """

  import Ecto.Query, warn: false
  alias CustomerPoints.Repo

  alias CustomerPoints.CustomerPointBalances.CustomerPointBalance

  def create_customer_point_balance(attrs \\ %{}) do
    %CustomerPointBalance{}
    |> CustomerPointBalance.changeset(attrs)
    |> Repo.insert()
  end
end
