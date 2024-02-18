defmodule CustomerPoints.CustomerBalances.CustomerBalance do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customer_balances" do
    field :balance_change, :integer
    field :new_balance, :integer
    field :prev_balance, :integer
    field :type, :string
    field :customer_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(customer_balance, attrs) do
    customer_balance
    |> cast(attrs, [:type, :prev_balance, :balance_change, :new_balance])
    |> validate_required([:type, :prev_balance, :balance_change, :new_balance])
  end
end
