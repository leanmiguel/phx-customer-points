defmodule CustomerPointsWeb.CustomerBalanceJSON do
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
end
