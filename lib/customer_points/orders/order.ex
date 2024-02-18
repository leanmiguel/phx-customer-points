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
    |> cast(attrs, [:order_id, :paid, :currency, :customer_id])
    |> validate_required([:order_id, :paid, :currency, :customer_id])
    |> validate_format(:currency, ~r/JPY/)
    |> validate_number(:paid, greater_than: 0)
    |> foreign_key_constraint(:customer_id)
  end
end
