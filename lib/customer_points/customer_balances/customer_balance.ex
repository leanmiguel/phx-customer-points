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
  def initial_changeset(customer_balance, attrs) do
    customer_balance
    |> cast(attrs, [:prev_balance, :balance_change, :new_balance, :customer_id])
    |> validate_required([:prev_balance, :balance_change, :new_balance, :customer_id])
  end

  def add_init_type(changeset) do
    put_change(changeset, :type, "initial")
  end

  def new_balance_changeset(customer_balance, attrs) do
    customer_balance
    |> cast(attrs, [:balance_change, :customer_id, :prev_balance])
    |> validate_required([:balance_change, :customer_id, :prev_balance])
  end

  defp check_not_negative_new_balance(changeset) do
    new_balance = get_field(changeset, :new_balance)

    if new_balance < 0 do
      prev_balance = get_field(changeset, :prev_balance)

      add_error(
        changeset,
        :new_balance,
        "cannot go below 0 balance, current balance: #{prev_balance}"
      )
    else
      changeset
    end
  end

  defp put_new_balance(changeset) do
    new_balance = get_field(changeset, :prev_balance) + get_field(changeset, :balance_change)
    put_change(changeset, :new_balance, new_balance)
  end

  defp determine_balance_type(changeset) do
    balance_change = get_field(changeset, :balance_change)

    if balance_change > 0 do
      put_change(changeset, :type, "deposit")
    else
      put_change(changeset, :type, "withdrawal")
    end
  end

  def new_balance_modifications(changeset) do
    changeset
    |> put_new_balance()
    |> check_not_negative_new_balance()
    |> determine_balance_type()
  end
end
