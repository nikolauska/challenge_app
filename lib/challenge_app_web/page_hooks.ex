defmodule ChallengeAppWeb.PageHooks do
  @moduledoc """
  Provides common page hooks to remove duplicated code from page live views
  """
  import Phoenix.LiveView
  import Phoenix.Component

  alias ChallengeApp.Sessions
  alias ChallengeApp.Pageviews
  alias ChallengeApp.PageMonitor

  def on_mount(socket, _params, %{"_csrf_token" => token}, view) do
    session = Sessions.get_or_create(token, get_connect_info(socket, :user_agent))
    pageview = Pageviews.create(session, view)

    case PageMonitor.monitor(self(), pageview.id) do
      {:ok, pid} ->
        socket
        |> assign(:session, session)
        |> assign(:pageview, pageview)
        |> assign(:monitor, pid)

      {:error, err} ->
        # TODO: Notify on error here for example in Sentry?
        socket
        |> assign(:session, session)
        |> assign(:pageview, pageview)
        |> assign(:monitor, nil)
    end
  end

  def on_mount(socket, _params, _session, _view) do
    # This happens on initial join from new user until we get the csrf token
    socket
    |> assign(:session, nil)
    |> assign(:pageview, nil)
    |> assign(:monitor, nil)
  end

  def on_hidden(%{assigns: %{monitor: nil}} = socket) do
    socket
  end

  def on_hidden(socket) do
    PageMonitor.update_visibility(socket.assigns.monitor, false)
    socket
  end

  def on_hidden(%{assigns: %{monitor: nil}} = socket) do
    socket
  end

  def on_visible(socket) do
    PageMonitor.update_visibility(socket.assigns.monitor, true)
    socket
  end
end
