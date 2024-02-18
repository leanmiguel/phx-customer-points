defmodule CustomerPoints.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :order_id, :uuid
      add :paid, :integer
      add :currency, :string
      add :customer_id, references(:customers, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:orders, [:customer_id])
  end
end
