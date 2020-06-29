defmodule Shop.Repo.Migrations.AddRoleToUsersTable do
  use Ecto.Migration

  def change do
    alter table("users") do
      # , null: false
      add :role, :text, defaut: "user"
    end
  end
end
