defmodule Shop.Orders.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :amount, :integer
    field :checkout_request, :string
    field :merchant_requeuest, :string
    field :mpesa_receipt_no, :string
    field :phone, :string
    field :order_id, :id

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:merchant_requeuest, :checkout_request, :mpesa_receipt_no, :amount, :phone])
    |> validate_required([:merchant_requeuest, :checkout_request, :mpesa_receipt_no, :amount, :phone])
    |> unique_constraint(:merchant_requeuest)
    |> unique_constraint(:checkout_request)
    |> unique_constraint(:mpesa_receipt_no)
  end
end
