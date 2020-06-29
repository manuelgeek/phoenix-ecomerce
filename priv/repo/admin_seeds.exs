users = [
  %{email: "eldo@mail.com", name: "Manu Admin", phone: "0722000000", role: "admin", password: "password"},
]

for user <- users do
  {:ok, _} = Shop.Accounts.create_user(user)
end