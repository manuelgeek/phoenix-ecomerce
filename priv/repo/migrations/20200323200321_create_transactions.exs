defmodule Shop.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :merchant_requeuest, :string
      add :checkout_request, :string
      add :mpesa_receipt_no, :string
      add :amount, :integer
      add :phone, :string
      add :order_id, references(:orders, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:transactions, [:merchant_requeuest])
    create unique_index(:transactions, [:checkout_request])
    create unique_index(:transactions, [:mpesa_receipt_no])
    create index(:transactions, [:order_id])
  end
end
