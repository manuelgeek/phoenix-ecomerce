defmodule Shop.Orders do
  @moduledoc """
  The Orders context.
  """

  import Ecto.Query, warn: false
  alias Shop.Repo

  alias Shop.Orders.Order

  def user_orders(params, user_id) do
    Order
    |> order_by(desc: :inserted_at)
    |> where([p], p.user_id == ^user_id)
    |> Repo.paginate(params)
  end

  def validate_order(attrs \\ %{}) do
    %Order{}
    |> Order.changeset(attrs)
  end

  def create_order(attrs \\ %{}) do
    %Order{}
    |> Order.changeset(attrs)
    |> Repo.insert()
  end

  def change_order(%Order{} = order) do
    Order.changeset(order, %{})
  end
end
