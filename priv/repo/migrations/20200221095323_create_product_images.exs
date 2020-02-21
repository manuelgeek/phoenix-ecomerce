defmodule Shop.Repo.Migrations.CreateProductImages do
  use Ecto.Migration

  def change do
    create table(:product_images) do
      add :name, :string
      add :product_id, references(:products, on_delete: :delete_all), null: false

      timestamps()
    end
  end
end
