defmodule Shop.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :code, :string
      add :amount, :integer
      add :shipping_fee, :integer
      add :delivery_address, :string
      add :items, :integer
      add :payment_method, :string
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

  end
end
