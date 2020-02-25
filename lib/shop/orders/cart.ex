defmodule Shop.Orders.Cart do
  use Ecto.Schema
  import Ecto.Changeset
  alias Shop.Products.Product
  alias Shop.Orders.Order

  schema "carts" do
    field :items, :integer
    belongs_to :product, Product
    belongs_to :order, Order

    timestamps()
  end

  @doc false
  def changeset(cart, attrs) do
    cart
    |> cast(attrs, [:items, :product_id, :order_id])
    |> validate_required([:items, :product_id, :order_id])
  end
end
