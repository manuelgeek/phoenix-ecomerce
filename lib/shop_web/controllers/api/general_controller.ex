defmodule ShopWeb.Api.GeneralController do
  @moduledoc false
  use ShopWeb, :controller
  alias Shop.Towns

  #   alias Shop.Services.Mpesa

  def addresses(conn, _) do
    addr = Towns.list_active_towns()

    conn
    |> put_status(200)
    |> json(%{data: addr})
  end

  def test(conn, _) do
    case Mpesa.make_request(10, "254724540039", "reference", "description") do
      {:ok, response} ->
        conn
        |> put_status(200)
        |> json(%{data: response})

      {:error, message} ->
        conn
        |> put_status(403)
        |> json(%{data: message})
    end
  end
end
