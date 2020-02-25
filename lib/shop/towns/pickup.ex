defmodule Shop.Towns.Pickup do
  use Ecto.Schema
  import Ecto.Changeset
  alias Shop.Towns.Town

  schema "pickups" do
    field :delivery_fee, :integer
    field :name, :string
    field :status, :boolean, default: true
    belongs_to :town, Town

    timestamps()
  end

  @doc false
  def changeset(pickup, attrs) do
    pickup
    |> cast(attrs, [:name, :status, :delivery_fee, :town_id])
    |> validate_required([:name, :status, :delivery_fee, :town_id])
  end
end
