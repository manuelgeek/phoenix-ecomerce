defmodule Shop.Categories do
  @moduledoc """
  The Categories context.
  """

  import Ecto.Query, warn: false
  alias Shop.Repo

  alias Shop.Categories.Category

  def list_categories do
    Repo.all(Category)
  end

  def list_active_categories do
    query =
      from u in Category,
        where: u.status == true

    Repo.all(query)
  end

  def get_category!(id), do: Repo.get!(Category, id)

  def get_by_slug!(slug) do
    Repo.get_by!(Category, slug: slug)
  end

  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  def change_category(%Category{} = category) do
    Category.changeset(category, %{})
  end
end
