defmodule ChallengeApp.PageMonitor.Monitor do
  @moduledoc """
  Monitor process which will check if liveview process
  is alive. It will also handle updating the engagement_time
  for the liveview process automatically so liveview process
  don't need to do it.
  """
  use GenServer

  alias ChallengeApp.Pageviews

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  @impl true
  def init(opts) do
    pid = Keyword.fetch!(opts, :pid)
    ref = Process.monitor(pid)

    {:ok,
     %{
       ref: ref,
       pid: pid,
       pageview_id: Keyword.fetch!(opts, :pageview_id),
       time: NaiveDateTime.local_now(),
       hidden: false
     }}
  end

  @impl true
  def handle_cast({:visible, false}, state) do
    # User moved the page into background so save the current engagement time
    seconds = NaiveDateTime.diff(NaiveDateTime.local_now(), state.time)
    Pageviews.update_engagement(state.pageview_id, seconds)

    # Set state to hidden so that we know if process dies to not update
    # the engagement_time
    {:noreply, Map.put(state, :hidden, true)}
  end

  @impl true
  def handle_cast({:visible, true}, state) do
    # Reset time to when page started to be visible to calculate time
    # user was looking at the page. Set hidden to false again so we
    # know to save the engagement_time if process dies
    state =
      state
      |> Map.put(:time, NaiveDateTime.local_now())
      |> Map.put(:hidden, false)

    {:noreply, state}
  end

  @impl true
  def handle_info({:DOWN, ref, :process, pid, _reason}, %{ref: ref, pid: pid} = state) do
    # When the liveview process goes down for any reason we need to update
    # the engagement time. Monitoring process will be killed after the liveview
    # process dies
    if not state.hidden do
      seconds = NaiveDateTime.diff(NaiveDateTime.local_now(), state.time)
      Pageviews.update_engagement(state.pageview_id, seconds)
    end

    # We can close the monitor instance as the process we were monitoring died
    {:stop, :normal, state}
  end
end
