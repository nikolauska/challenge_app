defmodule ChallengeApp.PageMonitor do
  @moduledoc """
  Page monitor helper functions to simplify monitoring
  pages and updating their visiblity
  """
  alias ChallengeApp.PageMonitor

  @doc """
  Start monitoring the liveview process
  """
  def monitor(pid, pageview_id) when is_pid(pid) and is_integer(pageview_id) do
    PageMonitor.Supervisor.start_child(pid, pageview_id)
  end

  @doc """
  Update visibility to monitoring process so the it knows if page
  is visible for the user
  """
  def update_visibility(pid, visible) when is_pid(pid) and is_boolean(visible) do
    GenServer.cast(pid, {:visible, visible})
  end
end
