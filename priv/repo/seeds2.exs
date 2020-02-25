
{:ok, town} = Shop.Towns.create_town(%{name: "Nairobi"})
shops = [
    %{name: "Kileleshwa", delivery_fee: 20, town_id: town.id },
    %{name: "Kikuyu", delivery_fee: 30, town_id: town.id },
    %{name: "Tom Mboya", delivery_fee: 10, town_id: town.id },
    %{name: "Umoja", delivery_fee: 25, town_id: town.id }
]
for shop <- shops do
    {:ok, _} = Shop.Towns.create_pickup(shop)
end

{:ok, town} = Shop.Towns.create_town(%{name: "Kisumu"})
shops = [
    %{name: "Mamboleo", delivery_fee: 10, town_id: town.id },
    %{name: "Ugunja", delivery_fee: 40, town_id: town.id },
    %{name: "Nyamasaria", delivery_fee: 16, town_id: town.id },
    %{name: "Kibos", delivery_fee: 35, town_id: town.id }
]
for shop <- shops do
    {:ok, _} = Shop.Towns.create_pickup(shop)
end

{:ok, town} = Shop.Towns.create_town(%{name: "Nakuru"})
shops = [
    %{name: "Mamboleo", delivery_fee: 10, town_id: town.id },
    %{name: "Kisumu Ndogo", delivery_fee: 40, town_id: town.id },
    %{name: "Majengo", delivery_fee: 26, town_id: town.id },
    %{name: "Town B", delivery_fee: 15, town_id: town.id }
]
for shop <- shops do
    {:ok, _} = Shop.Towns.create_pickup(shop)
end