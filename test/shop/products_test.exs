defmodule Shop.ProductsTest do
  use Shop.DataCase

  alias Shop.Products

  describe "products" do
    alias Shop.Products.Product

    @valid_attrs %{description: "some description", name: "some name", price: 42, slug: "some slug", status: true}
    @update_attrs %{description: "some updated description", name: "some updated name", price: 43, slug: "some updated slug", status: false}
    @invalid_attrs %{description: nil, name: nil, price: nil, slug: nil, status: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Products.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Products.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Products.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = Products.create_product(@valid_attrs)
      assert product.description == "some description"
      assert product.name == "some name"
      assert product.price == 42
      assert product.slug == "some slug"
      assert product.status == true
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, %Product{} = product} = Products.update_product(product, @update_attrs)
      assert product.description == "some updated description"
      assert product.name == "some updated name"
      assert product.price == 43
      assert product.slug == "some updated slug"
      assert product.status == false
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_product(product, @invalid_attrs)
      assert product == Products.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Products.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Products.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Products.change_product(product)
    end
  end

  describe "product_images" do
    alias Shop.Products.ProductImage

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def product_image_fixture(attrs \\ %{}) do
      {:ok, product_image} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Products.create_product_image()

      product_image
    end

    test "list_product_images/0 returns all product_images" do
      product_image = product_image_fixture()
      assert Products.list_product_images() == [product_image]
    end

    test "get_product_image!/1 returns the product_image with given id" do
      product_image = product_image_fixture()
      assert Products.get_product_image!(product_image.id) == product_image
    end

    test "create_product_image/1 with valid data creates a product_image" do
      assert {:ok, %ProductImage{} = product_image} = Products.create_product_image(@valid_attrs)
      assert product_image.name == "some name"
    end

    test "create_product_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_product_image(@invalid_attrs)
    end

    test "update_product_image/2 with valid data updates the product_image" do
      product_image = product_image_fixture()
      assert {:ok, %ProductImage{} = product_image} = Products.update_product_image(product_image, @update_attrs)
      assert product_image.name == "some updated name"
    end

    test "update_product_image/2 with invalid data returns error changeset" do
      product_image = product_image_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_product_image(product_image, @invalid_attrs)
      assert product_image == Products.get_product_image!(product_image.id)
    end

    test "delete_product_image/1 deletes the product_image" do
      product_image = product_image_fixture()
      assert {:ok, %ProductImage{}} = Products.delete_product_image(product_image)
      assert_raise Ecto.NoResultsError, fn -> Products.get_product_image!(product_image.id) end
    end

    test "change_product_image/1 returns a product_image changeset" do
      product_image = product_image_fixture()
      assert %Ecto.Changeset{} = Products.change_product_image(product_image)
    end
  end
end
