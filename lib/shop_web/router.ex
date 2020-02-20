defmodule ShopWeb.Router do
  use ShopWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ShopWeb do
    pipe_through :browser
    get "/", PageController, :index
    
    # get "/*path", GlobRouter, []
  end

  # Other scopes may use custom stacks.
  scope "/api", ShopWeb do
    pipe_through :api
  end
end

defmodule ShopWeb.GlobRouter do
  def init(opts), do: opts

  def call(%Plug.Conn{request_path: path} = conn, _opts) do
    cond do
      Regex.match?(~r{[\/\w\.-]} ,path) -> to(conn, ShopWeb.PageController, :index)
      true -> raise Phoenix.Router.NoRouteError, conn: conn, router: Router
    end
  end

  defp to(conn, controller, action) do
    controller.call(conn, controller.init(action))
  end
end
