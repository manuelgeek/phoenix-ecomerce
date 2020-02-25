defmodule Shop.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset
  alias Shop.Orders.Cart
  alias Shop.Accounts.User

  schema "orders" do
    field :amount, :integer
    field :code, :string
    field :delivery_address, :string
    field :items, :integer
    field :payment_method, :string
    field :shipping_fee, :integer
    has_many :carts, Cart, on_delete: :delete_all
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:code, :amount, :shipping_fee, :delivery_address, :items, :payment_method])
    |> validate_required([:code, :amount, :shipping_fee, :delivery_address, :items, :payment_method])
  end
end
