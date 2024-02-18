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
    |> cast(attrs, [:prev_balance, :balance_change, :new_balance, :customer_id])
    |> validate_required([:prev_balance, :balance_change, :new_balance, :customer_id])
  end

  def add_init_type(changeset) do
    put_change(changeset, :type, "initial")
  end

  def manual_balance_changeset(customer_balance, attrs) do
    customer_balance
    |> cast(attrs, [:balance_change, :customer_id])
    |> validate_required([:balance_change, :customer_id])
  end

  def put_prev_balance(changeset, prev_balance) do
    put_change(changeset, :prev_balance, prev_balance)
  end

  def put_new_balance(changeset) do
    new_balance = get_field(changeset, :prev_balance) + get_field(changeset, :balance_change)
    put_change(changeset, :new_balance, new_balance)
  end

  def determine_balance_type(changeset) do
    balance_change = get_field(changeset, :balance_change)

    if balance_change > 0 do
      put_change(changeset, :type, "deposit")
    else
      put_change(changeset, :type, "withdrawal")
    end
  end
end
