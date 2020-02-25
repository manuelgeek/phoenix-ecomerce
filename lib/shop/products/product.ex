defmodule Shop.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset
  alias Shop.Categories.Category
  alias Shop.Products.ProductImage
  #   @derive {Jason.Encoder, only: [:id, :name, :category]}
  @derive {Poison.Encoder,
           only: [:id, :name, :slug, :marked_price, :selling_price, :status, :description, :images]}

  schema "products" do
    field :description, :string
    field :name, :string
    field :marked_price, :integer
    field :selling_price, :integer
    field :slug, :string
    field :status, :boolean, default: true
    belongs_to :category, Category
    has_many :images, ProductImage, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [
      :name,
      :slug,
      :marked_price,
      :selling_price,
      :status,
      :description,
      :category_id
    ])
    |> validate_required([
      :name,
      :slug,
      :marked_price,
      :selling_price,
      :status,
      :description,
      :category_id
    ])
    |> unique_constraint(:slug)
  end
end
