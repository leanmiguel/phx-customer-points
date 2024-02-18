defmodule CustomerPoints.CustomerBalances do
  @moduledoc """
  The CustomerBalances context.
  """

  import Ecto.Query, warn: false
  alias CustomerPoints.Repo

  alias CustomerPoints.CustomerBalances.CustomerBalance

  @doc """
  Returns the list of customer_balances.

  ## Examples

      iex> list_customer_balances()
      [%CustomerBalance{}, ...]

  """
  def list_customer_balances do
    Repo.all(CustomerBalance)
  end

  @doc """
  Gets a single customer_balance.

  Raises `Ecto.NoResultsError` if the Customer balance does not exist.

  ## Examples

      iex> get_customer_balance!(123)
      %CustomerBalance{}

      iex> get_customer_balance!(456)
      ** (Ecto.NoResultsError)

  """
  def get_customer_balance!(customer_id) do
    Repo.one!(
      from cb in CustomerBalance,
        where: cb.customer_id == ^customer_id,
        order_by: [desc: cb.inserted_at],
        limit: 1
    )
  end

  @doc """
  Creates a customer_balance.

  ## Examples

      iex> create_customer_balance(%{field: value})
      {:ok, %CustomerBalance{}}

      iex> create_customer_balance(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_manual_customer_balance(attrs \\ %{}, customer_id) do
    b =
      Repo.one!(
        from cb in CustomerBalance,
          where: cb.customer_id == ^customer_id,
          order_by: [desc: cb.inserted_at],
          limit: 1
      )

    %CustomerBalance{
      customer_id: b.customer_id
    }
    |> CustomerBalance.manual_balance_changeset(attrs)
    |> CustomerBalance.put_prev_balance(b.new_balance)
    |> CustomerBalance.put_new_balance()
    |> CustomerBalance.determine_balance_type()
    |> Repo.insert()
  end

  @doc """
  Updates a customer_balance.

  ## Examples

      iex> update_customer_balance(customer_balance, %{field: new_value})
      {:ok, %CustomerBalance{}}

      iex> update_customer_balance(customer_balance, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_customer_balance(%CustomerBalance{} = customer_balance, attrs) do
    customer_balance
    |> CustomerBalance.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a customer_balance.

  ## Examples

      iex> delete_customer_balance(customer_balance)
      {:ok, %CustomerBalance{}}

      iex> delete_customer_balance(customer_balance)
      {:error, %Ecto.Changeset{}}

  """
  def delete_customer_balance(%CustomerBalance{} = customer_balance) do
    Repo.delete(customer_balance)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking customer_balance changes.

  ## Examples

      iex> change_customer_balance(customer_balance)
      %Ecto.Changeset{data: %CustomerBalance{}}

  """
  def change_customer_balance(%CustomerBalance{} = customer_balance, attrs \\ %{}) do
    CustomerBalance.changeset(customer_balance, attrs)
  end
end
