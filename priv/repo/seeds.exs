# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# It is also run when you use `mix ecto.setup` or `mix ecto.reset`
#

Faker.start()

users = [
  %{email: "emashmagak@gmail.com", name: "Manu Geek", phone: "0724540039", password: "password"},
  %{email: "john.smith@example.org", name: "Manu Geek", phone: "0724540099", password: "password"}
]

for user <- users do
  {:ok, _} = Shop.Accounts.create_user(user)
end

for a <- 0..4 do
  cat = Faker.Lorem.word()
  slg = Shop.Helpers.Helper.slugified_title(cat)
  {:ok, category} = Shop.Categories.create_category(%{name: cat, slug: slg})

  for s <- 0..10 do
    name = Faker.Lorem.sentence(2)
    slug = Shop.Helpers.Helper.slugified_title(name)
    price = Enum.random(50..150)
    sell_price = price - Enum.random(10..35)

    prod = %{
      name: name,
      slug: slug,
      description: Faker.Lorem.paragraph(),
      marked_price: price,
      selling_price: sell_price,
      category_id: category.id
    }

    {:ok, product} = Shop.Products.create_product(prod)

    for i <- 0..2 do
      {:ok, product} =
        Shop.Products.create_product_image(%{
          name: "/dist/img/products/product-1.jpg",
          product_id: product.id
        })
    end
  end
end
