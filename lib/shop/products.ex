defmodule Shop.Products do
  @moduledoc """
  The Products context.
  """

  import Ecto.Query, warn: false
  alias Shop.Repo

  alias Shop.Products.Product

  def list_products(params) do
    Product
    |> order_by(desc: :inserted_at)
    |> preload([:category, :images])
    |> Repo.paginate(params)
  end

  def get_product!(id), do: Repo.get!(Product, id)

  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  def change_product(%Product{} = product) do
    Product.changeset(product, %{})
  end

  alias Shop.Products.ProductImage

  def list_product_images do
    Repo.all(ProductImage)
  end

  def get_product_image!(id), do: Repo.get!(ProductImage, id)

  def create_product_image(attrs \\ %{}) do
    %ProductImage{}
    |> ProductImage.changeset(attrs)
    |> Repo.insert()
  end

  def update_product_image(%ProductImage{} = product_image, attrs) do
    product_image
    |> ProductImage.changeset(attrs)
    |> Repo.update()
  end

  def delete_product_image(%ProductImage{} = product_image) do
    Repo.delete(product_image)
  end

  def change_product_image(%ProductImage{} = product_image) do
    ProductImage.changeset(product_image, %{})
  end
end
