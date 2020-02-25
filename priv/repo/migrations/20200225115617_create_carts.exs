defmodule Shop.Repo.Migrations.CreateCarts do
  use Ecto.Migration

  def change do
    create table(:carts) do
      add :items, :integer
      add :product_id, references(:products, on_delete: :delete_all), null: false
      add :order_id, references(:orders, on_delete: :delete_all), null: false

      timestamps()
    end

  end
end
