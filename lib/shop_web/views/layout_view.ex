defmodule ShopWeb.LayoutView do
  use ShopWeb, :view

  def current_session(conn) do
    Plug.Conn.get_session(conn, :phauxth_session_id)
  end

  def year do
    {:ok, final} = Timex.now() |> Timex.format("{YYYY}")
    final
  end
end
