defmodule Shop.Repo.Migrations.CreateTowns do
  use Ecto.Migration

  def change do
    create table(:towns) do
      add :name, :string
      add :status, :boolean, default: false, null: false

      timestamps()
    end

  end
end
