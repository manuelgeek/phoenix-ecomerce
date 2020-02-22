defmodule ShopWeb.ProductView do
  use ShopWeb, :view
  import Scrivener.HTML

  def img(images) do
    [head | _tail] = images
    head.name
  end
end
