defmodule Shop.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Shop.Repo,
      # Start the endpoint when the application starts
      ShopWeb.Endpoint,
      # Starts a worker by calling: Shop.Worker.start_link(arg)
      # {Shop.Worker, arg},
      {ConCache,
       [
         name: :orders_cache,
         ttl_check_interval: :timer.seconds(600),
         global_ttl: :timer.seconds(600),
         touch_on_read: true
       ]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Shop.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ShopWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
