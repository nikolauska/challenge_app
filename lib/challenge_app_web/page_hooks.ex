defmodule ChallengeAppWeb.PageHooks do
  @moduledoc """
  Provides common page hooks to remove duplicated code from page live views
  """
  import Phoenix.LiveView
  import Phoenix.Component

  alias ChallengeApp.Sessions
  alias ChallengeApp.Pageviews

  def on_mount(socket, _params, %{"_csrf_token" => token}, view) do
    session = Sessions.get_or_create(token, get_connect_info(socket, :user_agent))

    socket
    |> assign(:session, session)
    |> assign(:pageview, Pageviews.create(session, view))
    |> assign(:time, NaiveDateTime.local_now())
    |> assign(:hidden, false)
  end

  def on_mount(socket, _params, _session, _view) do
    # This happens on initial join from new user until we get the csrf token
    socket
    |> assign(:session, nil)
    |> assign(:pageview, nil)
    |> assign(:time, NaiveDateTime.local_now())
    |> assign(:hidden, false)
  end

  def on_hidden(%{assigns: %{pageview: nil}} = socket) do
    socket
    |> assign(:hidden, true)
  end

  def on_hidden(socket) do
    seconds = NaiveDateTime.diff(NaiveDateTime.local_now(), socket.assigns.time)

    socket
    |> assign(:pageview, Pageviews.update_engagement(socket.assigns.pageview, seconds))
    |> assign(:hidden, true)
  end

  def on_visible(socket) do
    socket
    |> assign(:hidden, false)
    |> assign(:time, NaiveDateTime.local_now())
  end

  def on_terminate(_reason, socket) do
    if not socket.assigns.hidden and not is_nil(socket.assigns.pageview) do
      seconds = NaiveDateTime.diff(NaiveDateTime.local_now(), socket.assigns.time)

      # We might crash without
      if seconds > 0 do
        Pageviews.update_engagement(socket.assigns.pageview, seconds)
      end
    end

    :shutdown
  end
end
