defmodule Shop.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset
  alias Shop.Orders.Cart
  alias Shop.Accounts.User
  alias Shop.Orders.Transaction

  schema "orders" do
    field :amount, :integer
    field :code, :string
    field :delivery_address, :string
    field :items, :integer
    field :phone, :string
    field :payment_method, :string
    field :shipping_fee, :integer
    has_many :carts, Cart, on_delete: :delete_all
    belongs_to :user, User
    has_one :transaction, Transaction

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:code, :amount, :shipping_fee, :delivery_address, :items, :payment_method, :user_id, :phone])
    |> cast_assoc(:carts,  with: &Shop.Orders.Cart.changeset/2)
    |> validate_required([:code, :amount, :shipping_fee, :delivery_address, :items, :payment_method])
    |> valid_phone_no
  end

  defp valid_phone_no(changeset) do
    changeset
    |> validate_format(
      :phone,
      ~r/^(?:254|\+254|0)?((?:[71])[0-9][0-9][0-9]{6})$/
    )
  end
end
