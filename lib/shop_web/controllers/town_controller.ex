defmodule ShopWeb.TownController do
  use ShopWeb, :controller

  alias Shop.Towns
  alias Shop.Towns.Town

  def index(conn, _params) do
    towns = Towns.list_towns()
    render(conn, "index.html", towns: towns)
  end

  def new(conn, _params) do
    changeset = Towns.change_town(%Town{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"town" => town_params}) do
    case Towns.create_town(town_params) do
      {:ok, town} ->
        conn
        |> put_flash(:info, "Town created successfully.")
        |> redirect(to: Routes.town_path(conn, :show, town))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    town = Towns.get_town!(id)
    render(conn, "show.html", town: town)
  end

  def edit(conn, %{"id" => id}) do
    town = Towns.get_town!(id)
    changeset = Towns.change_town(town)
    render(conn, "edit.html", town: town, changeset: changeset)
  end

  def update(conn, %{"id" => id, "town" => town_params}) do
    town = Towns.get_town!(id)

    case Towns.update_town(town, town_params) do
      {:ok, town} ->
        conn
        |> put_flash(:info, "Town updated successfully.")
        |> redirect(to: Routes.town_path(conn, :show, town))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", town: town, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    town = Towns.get_town!(id)
    {:ok, _town} = Towns.delete_town(town)

    conn
    |> put_flash(:info, "Town deleted successfully.")
    |> redirect(to: Routes.town_path(conn, :index))
  end
end
