defmodule CustomerPoints.CustomerPointBalances.CustomerPointBalance do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customer_point_balances" do
    field :new_points, :integer
    field :points_change, :integer
    field :prev_points, :integer
    field :type, :string
    field :customer_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(customer_point_balance, attrs) do
    customer_point_balance
    |> cast(attrs, [:type, :prev_points, :points_change, :new_points])
    |> validate_required([:type, :prev_points, :points_change, :new_points])
  end
end
