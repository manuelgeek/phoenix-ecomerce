defmodule Shop.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset
  alias Shop.Categories.Category
  alias Shop.Products.ProductImage

  schema "products" do
    field :description, :string
    field :name, :string
    field :price, :integer
    field :slug, :string
    field :status, :boolean, default: false
    belongs_to :category, Category
    has_many :images, ProductImage, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :slug, :price, :status, :description])
    |> validate_required([:name, :slug, :price, :status, :description])
    |> unique_constraint(:slug)
  end
end
