defmodule ShopWeb.TownControllerTest do
  use ShopWeb.ConnCase

  alias Shop.Towns

  @create_attrs %{name: "some name", status: true}
  @update_attrs %{name: "some updated name", status: false}
  @invalid_attrs %{name: nil, status: nil}

  def fixture(:town) do
    {:ok, town} = Towns.create_town(@create_attrs)
    town
  end

  describe "index" do
    test "lists all towns", %{conn: conn} do
      conn = get(conn, Routes.town_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Towns"
    end
  end

  describe "new town" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.town_path(conn, :new))
      assert html_response(conn, 200) =~ "New Town"
    end
  end

  describe "create town" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.town_path(conn, :create), town: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.town_path(conn, :show, id)

      conn = get(conn, Routes.town_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Town"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.town_path(conn, :create), town: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Town"
    end
  end

  describe "edit town" do
    setup [:create_town]

    test "renders form for editing chosen town", %{conn: conn, town: town} do
      conn = get(conn, Routes.town_path(conn, :edit, town))
      assert html_response(conn, 200) =~ "Edit Town"
    end
  end

  describe "update town" do
    setup [:create_town]

    test "redirects when data is valid", %{conn: conn, town: town} do
      conn = put(conn, Routes.town_path(conn, :update, town), town: @update_attrs)
      assert redirected_to(conn) == Routes.town_path(conn, :show, town)

      conn = get(conn, Routes.town_path(conn, :show, town))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, town: town} do
      conn = put(conn, Routes.town_path(conn, :update, town), town: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Town"
    end
  end

  describe "delete town" do
    setup [:create_town]

    test "deletes chosen town", %{conn: conn, town: town} do
      conn = delete(conn, Routes.town_path(conn, :delete, town))
      assert redirected_to(conn) == Routes.town_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.town_path(conn, :show, town))
      end
    end
  end

  defp create_town(_) do
    town = fixture(:town)
    {:ok, town: town}
  end
end
