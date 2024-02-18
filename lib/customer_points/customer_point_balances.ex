defmodule CustomerPoints.CustomerPointBalances do
  @moduledoc """
  The CustomerPointBalances context.
  """

  import Ecto.Query, warn: false
  alias CustomerPoints.Repo

  alias CustomerPoints.CustomerPointBalances.CustomerPointBalance

  @doc """
  Returns the list of customer_point_balances.

  ## Examples

      iex> list_customer_point_balances()
      [%CustomerPointBalance{}, ...]

  """
  def list_customer_point_balances do
    Repo.all(CustomerPointBalance)
  end

  @doc """
  Gets a single customer_point_balance.

  Raises `Ecto.NoResultsError` if the Customer point balance does not exist.

  ## Examples

      iex> get_customer_point_balance!(123)
      %CustomerPointBalance{}

      iex> get_customer_point_balance!(456)
      ** (Ecto.NoResultsError)

  """
  def get_customer_point_balance!(id), do: Repo.get!(CustomerPointBalance, id)

  @doc """
  Creates a customer_point_balance.

  ## Examples

      iex> create_customer_point_balance(%{field: value})
      {:ok, %CustomerPointBalance{}}

      iex> create_customer_point_balance(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_customer_point_balance(attrs \\ %{}) do
    %CustomerPointBalance{}
    |> CustomerPointBalance.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a customer_point_balance.

  ## Examples

      iex> update_customer_point_balance(customer_point_balance, %{field: new_value})
      {:ok, %CustomerPointBalance{}}

      iex> update_customer_point_balance(customer_point_balance, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_customer_point_balance(%CustomerPointBalance{} = customer_point_balance, attrs) do
    customer_point_balance
    |> CustomerPointBalance.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a customer_point_balance.

  ## Examples

      iex> delete_customer_point_balance(customer_point_balance)
      {:ok, %CustomerPointBalance{}}

      iex> delete_customer_point_balance(customer_point_balance)
      {:error, %Ecto.Changeset{}}

  """
  def delete_customer_point_balance(%CustomerPointBalance{} = customer_point_balance) do
    Repo.delete(customer_point_balance)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking customer_point_balance changes.

  ## Examples

      iex> change_customer_point_balance(customer_point_balance)
      %Ecto.Changeset{data: %CustomerPointBalance{}}

  """
  def change_customer_point_balance(%CustomerPointBalance{} = customer_point_balance, attrs \\ %{}) do
    CustomerPointBalance.changeset(customer_point_balance, attrs)
  end
end
