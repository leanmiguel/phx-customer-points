defmodule CustomerPoints.Repo.Migrations.CreateCustomerBalances do
  use Ecto.Migration

  def change do
    create table(:customer_balances) do
      add :type, :string
      add :prev_balance, :integer
      add :balance_change, :integer
      add :new_balance, :integer
      add :customer_id, references(:customers, on_delete: :nothing), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:customer_balances, [:customer_id])
  end
end
