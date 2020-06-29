defmodule ShopWeb.Admin.DashboardController do
  @moduledoc false
  use ShopWeb, :controller
  import ShopWeb.Authorize

  def action(conn, _), do: auth_role(conn, ["admin"], __MODULE__)

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
