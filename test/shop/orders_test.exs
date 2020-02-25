defmodule Shop.OrdersTest do
  use Shop.DataCase

  alias Shop.Orders

  describe "orders" do
    alias Shop.Orders.Order

    @valid_attrs %{amount: 42, code: "some code", delivery_address: "some delivery_address", items: 42, payment_method: "some payment_method", shipping_fee: 42}
    @update_attrs %{amount: 43, code: "some updated code", delivery_address: "some updated delivery_address", items: 43, payment_method: "some updated payment_method", shipping_fee: 43}
    @invalid_attrs %{amount: nil, code: nil, delivery_address: nil, items: nil, payment_method: nil, shipping_fee: nil}

    def order_fixture(attrs \\ %{}) do
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Orders.create_order()

      order
    end

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Orders.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Orders.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = Orders.create_order(@valid_attrs)
      assert order.amount == 42
      assert order.code == "some code"
      assert order.delivery_address == "some delivery_address"
      assert order.items == 42
      assert order.payment_method == "some payment_method"
      assert order.shipping_fee == 42
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      assert {:ok, %Order{} = order} = Orders.update_order(order, @update_attrs)
      assert order.amount == 43
      assert order.code == "some updated code"
      assert order.delivery_address == "some updated delivery_address"
      assert order.items == 43
      assert order.payment_method == "some updated payment_method"
      assert order.shipping_fee == 43
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_order(order, @invalid_attrs)
      assert order == Orders.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Orders.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Orders.change_order(order)
    end
  end

  describe "carts" do
    alias Shop.Orders.Cart

    @valid_attrs %{items: 42}
    @update_attrs %{items: 43}
    @invalid_attrs %{items: nil}

    def cart_fixture(attrs \\ %{}) do
      {:ok, cart} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Orders.create_cart()

      cart
    end

    test "list_carts/0 returns all carts" do
      cart = cart_fixture()
      assert Orders.list_carts() == [cart]
    end

    test "get_cart!/1 returns the cart with given id" do
      cart = cart_fixture()
      assert Orders.get_cart!(cart.id) == cart
    end

    test "create_cart/1 with valid data creates a cart" do
      assert {:ok, %Cart{} = cart} = Orders.create_cart(@valid_attrs)
      assert cart.items == 42
    end

    test "create_cart/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_cart(@invalid_attrs)
    end

    test "update_cart/2 with valid data updates the cart" do
      cart = cart_fixture()
      assert {:ok, %Cart{} = cart} = Orders.update_cart(cart, @update_attrs)
      assert cart.items == 43
    end

    test "update_cart/2 with invalid data returns error changeset" do
      cart = cart_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_cart(cart, @invalid_attrs)
      assert cart == Orders.get_cart!(cart.id)
    end

    test "delete_cart/1 deletes the cart" do
      cart = cart_fixture()
      assert {:ok, %Cart{}} = Orders.delete_cart(cart)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_cart!(cart.id) end
    end

    test "change_cart/1 returns a cart changeset" do
      cart = cart_fixture()
      assert %Ecto.Changeset{} = Orders.change_cart(cart)
    end
  end
end
