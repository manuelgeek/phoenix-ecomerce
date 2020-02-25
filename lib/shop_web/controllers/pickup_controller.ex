defmodule ShopWeb.PickupController do
  use ShopWeb, :controller

  alias Shop.Towns
  alias Shop.Towns.Pickup

  def index(conn, _params) do
    pickups = Towns.list_pickups()
    render(conn, "index.html", pickups: pickups)
  end

  def new(conn, _params) do
    changeset = Towns.change_pickup(%Pickup{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"pickup" => pickup_params}) do
    case Towns.create_pickup(pickup_params) do
      {:ok, pickup} ->
        conn
        |> put_flash(:info, "Pickup created successfully.")
        |> redirect(to: Routes.pickup_path(conn, :show, pickup))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    pickup = Towns.get_pickup!(id)
    render(conn, "show.html", pickup: pickup)
  end

  def edit(conn, %{"id" => id}) do
    pickup = Towns.get_pickup!(id)
    changeset = Towns.change_pickup(pickup)
    render(conn, "edit.html", pickup: pickup, changeset: changeset)
  end

  def update(conn, %{"id" => id, "pickup" => pickup_params}) do
    pickup = Towns.get_pickup!(id)

    case Towns.update_pickup(pickup, pickup_params) do
      {:ok, pickup} ->
        conn
        |> put_flash(:info, "Pickup updated successfully.")
        |> redirect(to: Routes.pickup_path(conn, :show, pickup))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", pickup: pickup, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    pickup = Towns.get_pickup!(id)
    {:ok, _pickup} = Towns.delete_pickup(pickup)

    conn
    |> put_flash(:info, "Pickup deleted successfully.")
    |> redirect(to: Routes.pickup_path(conn, :index))
  end
end
