defmodule MealsOnWheels.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MealsOnWheels.Parser.MONSupervisor,
      MealsOnWheels.Repo,
      MealsOnWheelsWeb.Telemetry,
      {Phoenix.PubSub, name: MealsOnWheels.PubSub},
      MealsOnWheelsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MealsOnWheels.Supervisor]
    {:ok, _pid} = Supervisor.start_link(children, opts)

    MealsOnWheels.fetch()

    {:ok, _pid}
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  @spec config_change(any, any, any) :: :ok
  def config_change(changed, _new, removed) do
    MealsOnWheelsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
