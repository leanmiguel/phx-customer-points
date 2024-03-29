defmodule CustomerPointsWeb.CustomerBalanceJSON do
  alias CustomerPoints.CustomerBalances.CustomerBalance

  def show_customer_balance(%{
        customer_balance: customer_balance,
        customer_points_balance: customer_points_balance
      }) do
    %{
      data: %{
        current_balance: customer_balance.new_balance,
        current_points_balance: customer_points_balance.new_points
      }
    }
  end

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
