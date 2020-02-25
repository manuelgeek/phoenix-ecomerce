defmodule Shop.Towns.Town do
  use Ecto.Schema
  import Ecto.Changeset
  alias Shop.Towns.Pickup

  schema "towns" do
    field :name, :string
    field :status, :boolean, default: true
    has_many :pickups, Pickup, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(town, attrs) do
    town
    |> cast(attrs, [:name, :status])
    |> validate_required([:name, :status])
  end
end
