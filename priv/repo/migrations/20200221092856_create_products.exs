defmodule Shop.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :slug, :string
      add :price, :integer
      add :status, :boolean, default: true, null: false
      add :description, :text

      add :category_id, references(:categories, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index(:products, [:slug])
  end
end
