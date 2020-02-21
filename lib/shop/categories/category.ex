defmodule Shop.Categories.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias Shop.Products.Product

  schema "categories" do
    field :name, :string
    field :slug, :string
    field :status, :boolean, default: true
    has_many :products, Product, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name, :slug, :status])
    |> validate_required([:name, :slug, :status])
    |> unique_constraint(:slug)
  end
end
