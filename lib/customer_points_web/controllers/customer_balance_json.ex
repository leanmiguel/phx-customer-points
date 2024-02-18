defmodule CustomerPointsWeb.CustomerBalanceJSON do
  alias CustomerPoints.CustomerBalances.CustomerBalance

  @doc """
  Renders a list of customer_balances.
  """
  def index(%{customer_balances: customer_balances}) do
    %{data: for(customer_balance <- customer_balances, do: data(customer_balance))}
  end

  @doc """
  Renders a single customer_balance.
  """
  def show(%{customer_balance: customer_balance}) do
    %{data: data(customer_balance)}
  end

  defp data(%CustomerBalance{} = customer_balance) do
    %{
      id: customer_balance.id,
      type: customer_balance.type,
      prev_balance: customer_balance.prev_balance,
      balance_change: customer_balance.balance_change,
      new_balance: customer_balance.new_balance
    }
  end
end
