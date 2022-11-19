defmodule ChallengeApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ChallengeAppWeb.Telemetry,
      # Start the Ecto repository
      ChallengeApp.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ChallengeApp.PubSub},
      # Start the Endpoint (http/https)
      ChallengeAppWeb.Endpoint,
      # Start a worker by calling: ChallengeApp.Worker.start_link(arg)
      {ChallengeApp.PageMonitor.Supervisor, [name: ChallengeApp.PageMonitor.Supervisor]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ChallengeApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ChallengeAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
