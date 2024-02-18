defmodule CustomerPoints.Customers do
  @moduledoc """
  The Customers context.
  """

  import Ecto.Query, warn: false
  alias CustomerPoints.Repo

  alias CustomerPoints.Customers.Customer
  alias CustomerPoints.CustomerBalances.CustomerBalance
  alias CustomerPoints.CustomerPointBalances.CustomerPointBalance

  @doc """
  Returns the list of customers.

  ## Examples

      iex> list_customers()
      [%Customer{}, ...]

  """
  def list_customers do
    Repo.all(Customer)
  end

  @doc """
  Gets a single customer.

  Raises `Ecto.NoResultsError` if the Customer does not exist.

  ## Examples

      iex> get_customer!(123)
      %Customer{}

      iex> get_customer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_customer!(id), do: Repo.get!(Customer, id)

  @doc """
  Creates a customer.

  ## Examples

      iex> create_customer(%{field: value})
      {:ok, %Customer{}}

      iex> create_customer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_customer(attrs \\ %{}) do
    multi =
      Ecto.Multi.new()
      |> Ecto.Multi.insert(:customer, Customer.changeset(%Customer{}, attrs))
      |> Ecto.Multi.run(:customer_balance, fn _repo, %{customer: customer} ->
        CustomerBalance.changeset(%CustomerBalance{}, %{
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
        CustomerPointBalance.changeset(%CustomerPointBalance{}, %{
          type: "initial",
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

  @doc """
  Updates a customer.

  ## Examples

      iex> update_customer(customer, %{field: new_value})
      {:ok, %Customer{}}

      iex> update_customer(customer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_customer(%Customer{} = customer, attrs) do
    customer
    |> Customer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a customer.

  ## Examples

      iex> delete_customer(customer)
      {:ok, %Customer{}}

      iex> delete_customer(customer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_customer(%Customer{} = customer) do
    Repo.delete(customer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking customer changes.

  ## Examples

      iex> change_customer(customer)
      %Ecto.Changeset{data: %Customer{}}

  """
  def change_customer(%Customer{} = customer, attrs \\ %{}) do
    Customer.changeset(customer, attrs)
  end
end
