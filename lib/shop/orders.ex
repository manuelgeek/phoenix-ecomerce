defmodule Shop.Orders do
  @moduledoc """
  The Orders context.
  """

  import Ecto.Query, warn: false
  alias Shop.Repo

  alias Shop.Orders.Order

  def list_orders do
    Repo.all(Order)
  end

  def get_order!(id), do: Repo.get!(Order, id)

  def validate_order(attrs \\ %{}) do
    %Order{}
    |> Order.changeset(attrs)
  end

  def create_order(attrs \\ %{}) do
    %Order{}
    |> Order.changeset(attrs)
    |> Repo.insert()
  end

  def delete_order(%Order{} = order) do
    Repo.delete(order)
  end

  def change_order(%Order{} = order) do
    Order.changeset(order, %{})
  end

  # Cart
  alias Shop.Orders.Cart

  def list_carts do
    Repo.all(Cart)
  end

  def get_cart!(id), do: Repo.get!(Cart, id)

  def create_cart(attrs \\ %{}) do
    %Cart{}
    |> Cart.changeset(attrs)
    |> Repo.insert()
  end

  def update_cart(%Cart{} = cart, attrs) do
    cart
    |> Cart.changeset(attrs)
    |> Repo.update()
  end

  def delete_cart(%Cart{} = cart) do
    Repo.delete(cart)
  end

  def change_cart(%Cart{} = cart) do
    Cart.changeset(cart, %{})
  end
end
