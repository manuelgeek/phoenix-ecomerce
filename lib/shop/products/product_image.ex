defmodule Shop.Products.ProductImage do
  use Ecto.Schema
  import Ecto.Changeset
  alias Shop.Products.Product

  schema "product_images" do
    field :name, :string
    belongs_to :product, Product

    timestamps()
  end

  @doc false
  def changeset(product_image, attrs) do
    product_image
    |> cast(attrs, [:name, :product_id])
    |> validate_required([:name, :product_id])
  end
end
