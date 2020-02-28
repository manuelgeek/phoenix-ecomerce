defmodule ShopWeb.Api.GeneralController do
  @moduledoc false
  use ShopWeb, :controller
  alias Shop.Towns
  alias Shop.Services.Mpesa

  def addresses(conn, _) do
    addr = Towns.list_active_towns()

    conn
    |> put_status(200)
    |> json(%{data: addr})
  end

  def test(conn, _) do
    Mpesa.make_request()
    conn
  end
end
