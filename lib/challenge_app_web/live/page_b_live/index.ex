defmodule ChallengeAppWeb.PageBLive.Index do
  use ChallengeAppWeb, :live_view

  alias ChallengeApp.Sessions
  alias ChallengeAppWeb.PageHooks

  # Store view as static string so we don't need to constantly
  # load the same module name with __MODULE__
  @view "#{__MODULE__}"

  @impl true
  def mount(params, session, socket) do
    socket =
      socket
      |> assign(:page_title, "Page B")
      |> PageHooks.on_mount(params, session, @view)

    {:ok, socket}
  end

  @impl true
  def handle_event("redirect", %{"to" => to}, socket) do
    PageHooks.on_terminate(:normal, socket)

    {:noreply, push_redirect(socket, to: to)}
  end

  @impl true
  def handle_event("visibility", %{"state" => "hidden"}, socket) do
    {:noreply, PageHooks.on_hidden(socket)}
  end

  @impl true
  def handle_event("visibility", %{"state" => "visible"}, socket) do
    {:noreply, PageHooks.on_visible(socket)}
  end

  @impl true
  def terminate(reason, socket) do
    PageHooks.on_terminate(reason, socket)
  end
end
