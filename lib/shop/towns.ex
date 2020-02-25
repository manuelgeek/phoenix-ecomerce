defmodule Shop.Towns do
  @moduledoc """
  The Towns context.
  """

  import Ecto.Query, warn: false
  alias Shop.Repo

  alias Shop.Towns.Town

  @doc """
  Returns the list of towns.

  ## Examples

      iex> list_towns()
      [%Town{}, ...]

  """
  def list_towns do
    Repo.all(Town)
  end

  @doc """
  Gets a single town.

  Raises `Ecto.NoResultsError` if the Town does not exist.

  ## Examples

      iex> get_town!(123)
      %Town{}

      iex> get_town!(456)
      ** (Ecto.NoResultsError)

  """
  def get_town!(id), do: Repo.get!(Town, id)

  @doc """
  Creates a town.

  ## Examples

      iex> create_town(%{field: value})
      {:ok, %Town{}}

      iex> create_town(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_town(attrs \\ %{}) do
    %Town{}
    |> Town.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a town.

  ## Examples

      iex> update_town(town, %{field: new_value})
      {:ok, %Town{}}

      iex> update_town(town, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_town(%Town{} = town, attrs) do
    town
    |> Town.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a town.

  ## Examples

      iex> delete_town(town)
      {:ok, %Town{}}

      iex> delete_town(town)
      {:error, %Ecto.Changeset{}}

  """
  def delete_town(%Town{} = town) do
    Repo.delete(town)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking town changes.

  ## Examples

      iex> change_town(town)
      %Ecto.Changeset{source: %Town{}}

  """
  def change_town(%Town{} = town) do
    Town.changeset(town, %{})
  end

  alias Shop.Towns.Pickup

  @doc """
  Returns the list of pickups.

  ## Examples

      iex> list_pickups()
      [%Pickup{}, ...]

  """
  def list_pickups do
    Repo.all(Pickup)
  end

  @doc """
  Gets a single pickup.

  Raises `Ecto.NoResultsError` if the Pickup does not exist.

  ## Examples

      iex> get_pickup!(123)
      %Pickup{}

      iex> get_pickup!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pickup!(id), do: Repo.get!(Pickup, id)

  @doc """
  Creates a pickup.

  ## Examples

      iex> create_pickup(%{field: value})
      {:ok, %Pickup{}}

      iex> create_pickup(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pickup(attrs \\ %{}) do
    %Pickup{}
    |> Pickup.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pickup.

  ## Examples

      iex> update_pickup(pickup, %{field: new_value})
      {:ok, %Pickup{}}

      iex> update_pickup(pickup, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pickup(%Pickup{} = pickup, attrs) do
    pickup
    |> Pickup.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pickup.

  ## Examples

      iex> delete_pickup(pickup)
      {:ok, %Pickup{}}

      iex> delete_pickup(pickup)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pickup(%Pickup{} = pickup) do
    Repo.delete(pickup)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pickup changes.

  ## Examples

      iex> change_pickup(pickup)
      %Ecto.Changeset{source: %Pickup{}}

  """
  def change_pickup(%Pickup{} = pickup) do
    Pickup.changeset(pickup, %{})
  end
end
