defmodule ShopWeb.Api.GeneralController do
  @moduledoc false
  use ShopWeb, :controller
  alias Shop.Towns

  def addresses(conn, _) do
    addr = Towns.list_active_towns()
    conn
    |> put_status(200)
    |> json(%{data: addr})
  end
end
