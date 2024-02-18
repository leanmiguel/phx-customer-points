defmodule CustomerPoints.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :currency, :string
    field :order_id, Ecto.UUID
    field :paid, :integer
    field :customer_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:order_id, :paid, :currency])
    |> validate_required([:order_id, :paid, :currency])
  end
end
