defmodule ChallengeApp.PageMonitor.Supervisor do
  @moduledoc """
  Supervisor module for page monitor that handles starting
  monitoring processes
  """
  use DynamicSupervisor

  # Public

  def start_child(pid, pageview_id) when is_integer(pageview_id) do
    spec = {ChallengeApp.PageMonitor.Monitor, [pid: pid, pageview_id: pageview_id]}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  # Internal

  def start_link(init_arg) do
    DynamicSupervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
