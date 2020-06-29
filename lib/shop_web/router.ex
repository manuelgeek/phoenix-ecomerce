defmodule ShopWeb.Router do
  use ShopWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Phauxth.Authenticate
    plug Phauxth.Remember, create_session_func: &ShopWeb.Auth.Utils.create_session/1
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :admin do
    plug :put_layout, {ShopWeb.LayoutView, "admin.html"}
  end

  scope "/", ShopWeb do
    pipe_through :browser

    get "/register", UserController, :new
    post "/register", UserController, :create
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    post "/logout", SessionController, :delete

    get "/", ProductController, :index
    get "/categories/:category", ProductController, :category
    resources "/users", UserController, except: [:new, :create, :index]
    resources "/categories", CategoryController
    resources "/products", ProductController
    resources "/towns", TownController
    resources "/pickups", PickupController
    get "/cart", OrderController, :cart
    get "/checkout", OrderController, :checkout
    get "/orders", OrderController, :orders
    # resources "/sessions", SessionController, only: [:new, :create, :delete]

    # get "/*path", GlobRouter, []
    scope "/admin", Admin do
      pipe_through :admin

      get "/login", AuthController, :login
      post "/login", AuthController, :create
      post "/logout", AuthController, :delete

      get "/", DashboardController, :index
    end
  end

  # Other scopes may use custom stacks.
  scope "/api", ShopWeb.Api do
    pipe_through :api
    get "/addresses", GeneralController, :addresses
    get "/test", GeneralController, :test
    post "/order/make", OrdersController, :make_order
    post "/payment/callback", OrdersController, :payment_response
  end
end

defmodule ShopWeb.GlobRouter do
  def init(opts), do: opts

  def call(%Plug.Conn{request_path: path} = conn, _opts) do
    cond do
      Regex.match?(~r{[\/\w\.-]}, path) -> to(conn, ShopWeb.PageController, :index)
      true -> raise Phoenix.Router.NoRouteError, conn: conn, router: Router
    end
  end

  defp to(conn, controller, action) do
    controller.call(conn, controller.init(action))
  end
end
