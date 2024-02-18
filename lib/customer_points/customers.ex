defmodule CustomerPoints.Customers do
  @moduledoc """
  The Customers context.
  """

  import Ecto.Query, warn: false
  alias CustomerPoints.Repo

  alias CustomerPoints.Customers.Customer
  alias CustomerPoints.CustomerBalances.CustomerBalance
  alias CustomerPoints.CustomerPointBalances.CustomerPointBalance

  def get_customer_by_email_or_number(email, number)
      when is_binary(email) and is_binary(number) and email != "" and number != "" do
    query =
      from c in Customer,
        where: c.email == ^email or c.phone_number == ^number,
        select: %Customer{id: c.id}

    Repo.one!(query)
  end

  def get_customer_by_email_or_number(email, "") when is_binary(email) and email != "" do
    query =
      from c in Customer,
        where: c.email == ^email,
        select: %Customer{id: c.id}

    Repo.one!(query)
  end

  def get_customer_by_email_or_number("", number) when is_binary(number) and number != "" do
    query =
      from c in Customer,
        where: c.phone_number == ^number,
        select: %Customer{id: c.id}

    Repo.one!(query)
  end

  def get_customer_by_email_or_number(nil, nil), do: nil

  def get_customer_by_email_or_number(email, nil) when is_binary(email) and email != "",
    do: get_customer_by_email_or_number(email, "")

  def get_customer_by_email_or_number(nil, number) when is_binary(number) and number != "",
    do: get_customer_by_email_or_number("", number)

  def get_customer_by_email_or_number(_, _), do: nil

  def create_customer(attrs \\ %{}) do
    multi =
      Ecto.Multi.new()
      |> Ecto.Multi.insert(:customer, Customer.changeset(%Customer{}, attrs))
      |> Ecto.Multi.run(:customer_balance, fn _repo, %{customer: customer} ->
        CustomerBalance.initial_changeset(%CustomerBalance{}, %{
          type: "initial",
          prev_balance: 0,
          balance_change: 0,
          new_balance: 0,
          customer_id: customer.id
        })
        |> CustomerBalance.add_init_type()
        |> Repo.insert()
      end)
      |> Ecto.Multi.run(:customer_point_balance, fn _repo, %{customer: customer} ->
        CustomerPointBalance.initial_changeset(%CustomerPointBalance{}, %{
          prev_points: 0,
          points_change: 0,
          new_points: 0,
          customer_id: customer.id
        })
        |> Repo.insert()
      end)

    case Repo.transaction(multi) do
      {:ok, %{customer: customer}} ->
        {:ok, customer}

      {:error, _, reason, _changes} ->
        {:error, reason}
    end
  end
end
