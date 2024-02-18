defmodule CustomerPoints.CustomerPointBalances.CustomerPointBalance do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customer_point_balances" do
    field :new_points, :integer
    field :points_change, :integer
    field :prev_points, :integer
    field :customer_id, :id

    timestamps(type: :utc_datetime)
  end

  # set to only grow points for now
  def initial_changeset(customer_point_balance, attrs) do
    customer_point_balance
    |> cast(attrs, [:prev_points, :points_change, :new_points, :customer_id])
    |> validate_required([:prev_points, :points_change, :new_points, :customer_id])
    |> foreign_key_constraint(:customer_id)
  end

  def new_changeset(customer_point_balance, attrs) do
    customer_point_balance
    |> cast(attrs, [:points_change, :customer_id, :prev_points])
    |> validate_required([:points_change, :customer_id, :prev_points])
  end

  defp put_new_points_balance(changeset) do
    new_points_balance = get_field(changeset, :prev_points) + get_field(changeset, :points_change)
    put_change(changeset, :new_points, new_points_balance)
  end

  def new_point_balance_modifications(changeset) do
    changeset
    |> put_new_points_balance()
  end
end
