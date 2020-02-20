defmodule ShopWeb.LayoutView do
  use ShopWeb, :view

  def year do
    {:ok, final} = Timex.now |> Timex.format("{YYYY}")
    final
  end
end
