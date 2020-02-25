defmodule Shop.Towns do
  @moduledoc """
  The Towns context.
  """

  import Ecto.Query, warn: false
  alias Shop.Repo

  alias Shop.Towns.Town

  def list_towns do
    Repo.all(Town)
  end

  def list_active_towns do
    query =
      from u in Town,
        where: u.status == true,
        join: a in assoc(u, :pickups),
        preload: [pickups: a]

    Repo.all(query)
  end

  def get_town!(id), do: Repo.get!(Town, id)

  def create_town(attrs \\ %{}) do
    %Town{}
    |> Town.changeset(attrs)
    |> Repo.insert()
  end

  def update_town(%Town{} = town, attrs) do
    town
    |> Town.changeset(attrs)
    |> Repo.update()
  end

  def delete_town(%Town{} = town) do
    Repo.delete(town)
  end

  def change_town(%Town{} = town) do
    Town.changeset(town, %{})
  end

  alias Shop.Towns.Pickup

  def list_pickups do
    Repo.all(Pickup)
  end

  def get_pickup!(id), do: Repo.get!(Pickup, id)

  def create_pickup(attrs \\ %{}) do
    %Pickup{}
    |> Pickup.changeset(attrs)
    |> Repo.insert()
  end

  def update_pickup(%Pickup{} = pickup, attrs) do
    pickup
    |> Pickup.changeset(attrs)
    |> Repo.update()
  end

  def delete_pickup(%Pickup{} = pickup) do
    Repo.delete(pickup)
  end

  def change_pickup(%Pickup{} = pickup) do
    Pickup.changeset(pickup, %{})
  end
end
