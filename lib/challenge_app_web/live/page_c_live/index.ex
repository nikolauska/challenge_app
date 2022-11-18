defmodule ChallengeAppWeb.PageCLive.Index do
  use ChallengeAppWeb, :live_view

  alias ChallengeApp.Pageviews
  alias ChallengeAppWeb.PageHooks

  # Allowed tab numbers for page c
  @tabs ~w(1 2)

  # Store view as static string so we don't need to constantly
  # load the same module name with __MODULE__
  @view "#{__MODULE__}"

  @impl true
  def mount(%{"tab" => tab} = params, session, socket) when tab in @tabs do
    socket =
      socket
      |> assign(:page_title, "Page C, Tab #{tab}")
      |> assign(:tab, tab)
      |> PageHooks.on_mount(params, session, @view)

    {:ok, socket}
  end

  def mount(params, session, socket) do
    tab = Enum.random(@tabs)

    socket =
      socket
      |> assign(:page_title, "Page C, Tab #{tab}")
      |> assign(:tab, tab)
      |> PageHooks.on_mount(params, session, @view)
      |> push_redirect(to: ~p"/page_c/tab_#{tab}", replace: true)

    {:ok, socket}
  end

  @impl true
  def handle_event("set_tab", %{"tab" => tab}, socket) when tab in @tabs do
    socket =
      socket
      |> assign(:page_title, "Page C, Tab #{tab}")
      |> assign(:tab, tab)
      |> push_redirect(to: ~p"/page_c/tab_#{tab}", replace: true)

    {:noreply, socket}
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
