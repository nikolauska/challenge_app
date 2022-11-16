defmodule ChallengeAppWeb.PageHooks do
  @moduledoc """
  Provides common page hooks to remove duplicated code from page live views
  """
  import Phoenix.LiveView
  import Phoenix.Component

  alias ChallengeApp.Sessions
  alias ChallengeApp.Pageviews

  def on_mount(:session, _params, %{"_csrf_token" => token}, socket) do
    session = Sessions.get_or_create(token, get_connect_info(socket, :user_agent))

    {:cont, assign(socket, :session, session)}
  end

  def assign_defaults(socket, view) do
    socket
    |> assign(:pageview, Pageviews.create(socket.assigns.session, view))
    |> assign(:time, NaiveDateTime.local_now())
    |> assign(:hidden, false)
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
    if not socket.assigns.hidden do
      seconds = NaiveDateTime.diff(NaiveDateTime.local_now(), socket.assigns.time)

      # We might crash without
      if seconds > 0 do
        Pageviews.update_engagement(socket.assigns.pageview, seconds)
      end
    end

    :shutdown
  end
end
