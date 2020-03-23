defmodule Shop.Helpers.Helper do
  alias ShopWeb.ErrorView
  use ShopWeb, :controller

  def slugified_title(title) do
    title
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9\s-]/, "")
    |> String.replace(~r/(\s|-)+/, "-")
  end

  def nothing_found(conn) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render(:"404")
  end

  def gen_reference() do
    min = String.to_integer("100000", 36)
    max = String.to_integer("ZZZZZZ", 36)

    max
    |> Kernel.-(min)
    |> :rand.uniform()
    |> Kernel.+(min)
    |> Integer.to_string(36)
  end

  def randomizer(length, type \\ :all) do
    alphabets = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    numbers = "0123456789"

    lists =
      cond do
        type == :alpha -> alphabets <> String.downcase(alphabets)
        type == :numeric -> numbers
        type == :upcase -> alphabets
        type == :downcase -> String.downcase(alphabets)
        true -> alphabets <> String.downcase(alphabets) <> numbers
      end
      |> String.split("", trim: true)

    do_randomizer(length, lists)
  end

  @doc false
  defp get_range(length) when length > 1, do: 1..length
  defp get_range(length), do: [1]

  @doc false
  defp do_randomizer(length, lists) do
    get_range(length)
    |> Enum.reduce([], fn _, acc -> [Enum.random(lists) | acc] end)
    |> Enum.join("")
  end
end
