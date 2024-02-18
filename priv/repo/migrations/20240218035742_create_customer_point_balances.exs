defmodule CustomerPoints.Repo.Migrations.CreateCustomerPointBalances do
  use Ecto.Migration

  def change do
    create table(:customer_point_balances) do
      add :type, :string
      add :prev_points, :integer
      add :points_change, :integer
      add :new_points, :integer
      add :customer_id, references(:customers, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:customer_point_balances, [:customer_id])
  end
end
