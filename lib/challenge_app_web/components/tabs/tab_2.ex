defmodule ChallengeAppWeb.Tabs.Tab2 do
  use ChallengeAppWeb, :live_component

  def render(assigns) do
    ~H"""
    <a phx-click="redirect" phx-value-to={~p"/page_a"}>A</a>
    """
  end
end
