defmodule ShopWeb.OrderController do
  use ShopWeb, :controller
  import ShopWeb.Authorize

  plug :user_check when action in [:checkout]

  def cart(conn, _params) do
    render(conn, "cart.html")
  end

  def checkout(conn, _) do
    render(conn, "checkout.html")
  end
end
