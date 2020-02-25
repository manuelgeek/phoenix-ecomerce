defmodule ShopWeb.OrderController do
  use ShopWeb, :controller
  import ShopWeb.Authorize
  plug :user_check  when action in [:index, :show]

  def cart(conn, _params) do
    render(conn, "cart.html")
  end
end
