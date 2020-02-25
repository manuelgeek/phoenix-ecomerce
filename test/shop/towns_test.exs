defmodule Shop.TownsTest do
  use Shop.DataCase

  alias Shop.Towns

  describe "towns" do
    alias Shop.Towns.Town

    @valid_attrs %{name: "some name", status: true}
    @update_attrs %{name: "some updated name", status: false}
    @invalid_attrs %{name: nil, status: nil}

    def town_fixture(attrs \\ %{}) do
      {:ok, town} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Towns.create_town()

      town
    end

    test "list_towns/0 returns all towns" do
      town = town_fixture()
      assert Towns.list_towns() == [town]
    end

    test "get_town!/1 returns the town with given id" do
      town = town_fixture()
      assert Towns.get_town!(town.id) == town
    end

    test "create_town/1 with valid data creates a town" do
      assert {:ok, %Town{} = town} = Towns.create_town(@valid_attrs)
      assert town.name == "some name"
      assert town.status == true
    end

    test "create_town/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Towns.create_town(@invalid_attrs)
    end

    test "update_town/2 with valid data updates the town" do
      town = town_fixture()
      assert {:ok, %Town{} = town} = Towns.update_town(town, @update_attrs)
      assert town.name == "some updated name"
      assert town.status == false
    end

    test "update_town/2 with invalid data returns error changeset" do
      town = town_fixture()
      assert {:error, %Ecto.Changeset{}} = Towns.update_town(town, @invalid_attrs)
      assert town == Towns.get_town!(town.id)
    end

    test "delete_town/1 deletes the town" do
      town = town_fixture()
      assert {:ok, %Town{}} = Towns.delete_town(town)
      assert_raise Ecto.NoResultsError, fn -> Towns.get_town!(town.id) end
    end

    test "change_town/1 returns a town changeset" do
      town = town_fixture()
      assert %Ecto.Changeset{} = Towns.change_town(town)
    end
  end

  describe "pickups" do
    alias Shop.Towns.Pickup

    @valid_attrs %{delivery_fee: 42, name: "some name", status: true}
    @update_attrs %{delivery_fee: 43, name: "some updated name", status: false}
    @invalid_attrs %{delivery_fee: nil, name: nil, status: nil}

    def pickup_fixture(attrs \\ %{}) do
      {:ok, pickup} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Towns.create_pickup()

      pickup
    end

    test "list_pickups/0 returns all pickups" do
      pickup = pickup_fixture()
      assert Towns.list_pickups() == [pickup]
    end

    test "get_pickup!/1 returns the pickup with given id" do
      pickup = pickup_fixture()
      assert Towns.get_pickup!(pickup.id) == pickup
    end

    test "create_pickup/1 with valid data creates a pickup" do
      assert {:ok, %Pickup{} = pickup} = Towns.create_pickup(@valid_attrs)
      assert pickup.delivery_fee == 42
      assert pickup.name == "some name"
      assert pickup.status == true
    end

    test "create_pickup/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Towns.create_pickup(@invalid_attrs)
    end

    test "update_pickup/2 with valid data updates the pickup" do
      pickup = pickup_fixture()
      assert {:ok, %Pickup{} = pickup} = Towns.update_pickup(pickup, @update_attrs)
      assert pickup.delivery_fee == 43
      assert pickup.name == "some updated name"
      assert pickup.status == false
    end

    test "update_pickup/2 with invalid data returns error changeset" do
      pickup = pickup_fixture()
      assert {:error, %Ecto.Changeset{}} = Towns.update_pickup(pickup, @invalid_attrs)
      assert pickup == Towns.get_pickup!(pickup.id)
    end

    test "delete_pickup/1 deletes the pickup" do
      pickup = pickup_fixture()
      assert {:ok, %Pickup{}} = Towns.delete_pickup(pickup)
      assert_raise Ecto.NoResultsError, fn -> Towns.get_pickup!(pickup.id) end
    end

    test "change_pickup/1 returns a pickup changeset" do
      pickup = pickup_fixture()
      assert %Ecto.Changeset{} = Towns.change_pickup(pickup)
    end
  end
end
