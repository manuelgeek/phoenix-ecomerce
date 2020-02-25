defmodule ShopWeb.PartialsView do
  use ShopWeb, :view
  alias Shop.Categories
  alias Shop.Products

  def img(images) do
    [head | _tail] = images
    head.name
  end

  def categories do
    Categories.list_active_categories()
  end

  def latest_products do
    Products.get_latest_products()
  end

  def related_products(category) do
    Products.get_related_products(category)
  end

  def percentage_off(selling, marked) do
    ((marked - selling) / marked * 100) |> round
  end
end
