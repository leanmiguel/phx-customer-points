defmodule CustomerPointsWeb.CustomerJSON do
  alias CustomerPoints.Customers.Customer

  @doc """
  Renders a list of customers.
  """
  def index(%{customers: customers}) do
    %{data: for(customer <- customers, do: data(customer))}
  end

  @doc """
  Renders a single customer.
  """
  def show(%{customer: customer}) do
    %{data: data(customer)}
  end

  defp data(%Customer{} = customer) do
    %{
      id: customer.id,
      email: customer.email,
      phone_number: customer.phone_number
    }
  end
end
