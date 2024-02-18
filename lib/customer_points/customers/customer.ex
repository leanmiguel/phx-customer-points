defmodule CustomerPoints.Customers.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customers" do
    field :email, :string
    field :phone_number, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:email, :phone_number])
    |> validate_required_inclusion([:email, :phone_number])
    |> validate_format(:email, ~r/@/)
    |> validate_format(:phone_number, ~r/^\+?[1-9]\d{1,14}$/)
    |> unique_constraint(:email)
    |> unique_constraint(:phone_number)
  end

  def validate_required_inclusion(changeset, fields) do
    if Enum.any?(fields, &present?(changeset, &1)) do
      changeset
    else
      add_error(changeset, hd(fields), "One of these fields must be present: #{inspect(fields)}")
    end
  end

  def present?(changeset, field) do
    value = get_field(changeset, field)
    value && value != ""
  end
end
