defmodule ShopWeb.OrderController do
  use ShopWeb, :controller
  import ShopWeb.Authorize
  alias Shop.Orders

  plug :user_check when action in [:checkout, :orders]

  def cart(conn, _params) do
    render(conn, "cart.html")
  end

  def checkout(conn, _) do
    render(conn, "checkout.html")
  end

  def orders(%Plug.Conn{assigns: %{current_user: current_user}} = conn, params) do
    page = Orders.user_orders(params, current_user.id)
    render(conn, "orders.html", orders: page.entries, page: page)
  end
end
