defmodule Shop.Repo.Migrations.CreatePickups do
  use Ecto.Migration

  def change do
    create table(:pickups) do
      add :name, :string
      add :status, :boolean, default: false, null: false
      add :delivery_fee, :integer
      add :order_id, references(:towns, on_delete: :delete_all), null: false

      timestamps()
    end

  end
end
