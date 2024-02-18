defmodule CustomerPoints.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :email, :string
      add :phone_number, :string

      timestamps(type: :utc_datetime)
    end
  end
end
