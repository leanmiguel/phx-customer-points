defmodule CustomerPointsWeb.CustomerPointBalanceJSON do
  alias CustomerPoints.CustomerPointBalances.CustomerPointBalance

  @doc """
  Renders a list of customer_point_balances.
  """
  def index(%{customer_point_balances: customer_point_balances}) do
    %{data: for(customer_point_balance <- customer_point_balances, do: data(customer_point_balance))}
  end

  @doc """
  Renders a single customer_point_balance.
  """
  def show(%{customer_point_balance: customer_point_balance}) do
    %{data: data(customer_point_balance)}
  end

  defp data(%CustomerPointBalance{} = customer_point_balance) do
    %{
      id: customer_point_balance.id,
      type: customer_point_balance.type,
      prev_points: customer_point_balance.prev_points,
      points_change: customer_point_balance.points_change,
      new_points: customer_point_balance.new_points
    }
  end
end
