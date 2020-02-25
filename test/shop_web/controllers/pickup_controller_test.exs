defmodule ShopWeb.PickupControllerTest do
  use ShopWeb.ConnCase

  alias Shop.Towns

  @create_attrs %{delivery_fee: 42, name: "some name", status: true}
  @update_attrs %{delivery_fee: 43, name: "some updated name", status: false}
  @invalid_attrs %{delivery_fee: nil, name: nil, status: nil}

  def fixture(:pickup) do
    {:ok, pickup} = Towns.create_pickup(@create_attrs)
    pickup
  end

  describe "index" do
    test "lists all pickups", %{conn: conn} do
      conn = get(conn, Routes.pickup_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Pickups"
    end
  end

  describe "new pickup" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.pickup_path(conn, :new))
      assert html_response(conn, 200) =~ "New Pickup"
    end
  end

  describe "create pickup" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.pickup_path(conn, :create), pickup: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.pickup_path(conn, :show, id)

      conn = get(conn, Routes.pickup_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Pickup"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.pickup_path(conn, :create), pickup: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Pickup"
    end
  end

  describe "edit pickup" do
    setup [:create_pickup]

    test "renders form for editing chosen pickup", %{conn: conn, pickup: pickup} do
      conn = get(conn, Routes.pickup_path(conn, :edit, pickup))
      assert html_response(conn, 200) =~ "Edit Pickup"
    end
  end

  describe "update pickup" do
    setup [:create_pickup]

    test "redirects when data is valid", %{conn: conn, pickup: pickup} do
      conn = put(conn, Routes.pickup_path(conn, :update, pickup), pickup: @update_attrs)
      assert redirected_to(conn) == Routes.pickup_path(conn, :show, pickup)

      conn = get(conn, Routes.pickup_path(conn, :show, pickup))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, pickup: pickup} do
      conn = put(conn, Routes.pickup_path(conn, :update, pickup), pickup: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Pickup"
    end
  end

  describe "delete pickup" do
    setup [:create_pickup]

    test "deletes chosen pickup", %{conn: conn, pickup: pickup} do
      conn = delete(conn, Routes.pickup_path(conn, :delete, pickup))
      assert redirected_to(conn) == Routes.pickup_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.pickup_path(conn, :show, pickup))
      end
    end
  end

  defp create_pickup(_) do
    pickup = fixture(:pickup)
    {:ok, pickup: pickup}
  end
end
