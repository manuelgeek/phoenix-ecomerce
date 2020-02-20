defmodule Shop.Categories.Category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "categories" do
    field :name, :string
    field :slug, :string
    field :status, :boolean, default: true

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
